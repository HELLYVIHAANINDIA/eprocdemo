package com.eprocurement.etender.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.EncryptDecryptUtils;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.model.TblCommittee;
import com.eprocurement.etender.model.TblCommitteeEnvelope;
import com.eprocurement.etender.model.TblCommitteeUser;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblDesignation;
import com.eprocurement.etender.model.TblOfficer;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.services.CommitteeService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.OfficerService;

@Controller
@RequestMapping("/etender")
public class CommitteeController {
	
	
	@Autowired
	private ExceptionHandlerService exceptionHandlerService;
	
	@Autowired
	private EncryptDecryptUtils encryptDecryptUtils;
	
	@Autowired
	private CommitteeService committeeFormationService;
	
	@Autowired
	private TenderCommonService tenderCommonService;
	
	@Autowired
	private OfficerService userService;
	@Autowired
	private CommonService commonService;
	@Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	
	
	private static final int TAB_TENDER_OPENING = 7;
	private static final int TAB_EVALUATE_BID = 8;
	
	private static final String TENDER_ID = "tenderId";
	private static final String COMMITTEE_TYPE = "committeeType";
	private static final String IS_CERT_REQUIRED = "isCertRequired";
	private static final String ENV_LIST = "envList";
	private static final String IS_DECRYPTER_REQ = "isDecrypterReq";
	private static final String IS_2LEVEL_ENC = "is2LevelEnc";
	private static final String MIN_APPROVAL_REQ = "minApprovalReq_";
	private static final String SESSIONEXPIRED = "sessionexpired";
    private static final String IS_MULTILEVEL_EVALUATION_REQ = "multiLevelEvaluationReq";
    private static final String IS_TWO_STAGE_EVALUATION = "isTwoStageEvaluation";
    private static final String IS_TWO_STAGE_OPENING = "isTwoStageOpening";
    @Value("#{projectProperties['tenderPrebidObjectId']}")
    private String tenderPrebidObjectId;
	
	
	/**
	 * @param tenderId
	 * @param committeeType
	 * @param request
	 * @param modelMap
	 * @return
	 * 
	 */
	@RequestMapping(value="/buyer/createcommittee/{tenderId}/{committeeType}", method=RequestMethod.GET)
	public String createCommittee(@PathVariable(TENDER_ID) Integer tenderId, @PathVariable(COMMITTEE_TYPE) Integer committeeType, HttpServletRequest request , ModelMap modelMap){
		int envCount = 0;
		int isDecrypterReq = 0;
		int minMember = 1;
	    int isTWoStageOpening=0;
	    int validationMsgFlag=0;
	    StringBuilder json = new StringBuilder("[");
	    String jsonStr = "";
	    String grandParentDeptJson="";
	    SessionBean sessionBean = null;
		try {
			sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
			List<Object[]> tenderFields = tenderCommonService.getTenderFields(tenderId, "encryptionLevel,isCertRequired,isTwoStageEvaluation,multiLevelEvaluationReq,isTwoStageOpening,decryptorRequired");
			if(tenderFields != null && !tenderFields.isEmpty()){
				modelMap.put(IS_2LEVEL_ENC, tenderFields.get(0)[0]);	
				modelMap.put(IS_CERT_REQUIRED, tenderFields.get(0)[1]);
				modelMap.put(IS_TWO_STAGE_EVALUATION, tenderFields.get(0)[2]);
				modelMap.put(IS_MULTILEVEL_EVALUATION_REQ, tenderFields.get(0)[3]);
                modelMap.put(IS_TWO_STAGE_OPENING, tenderFields.get(0)[4]);
                isTWoStageOpening=Integer.parseInt(tenderFields.get(0)[4].toString());
				List<Object[]> envList = committeeFormationService.getTenderEnvelopesDetails(tenderId);
				if(envList != null && !envList.isEmpty()){
					envCount = envList.size();
					if(committeeType == 1){
						//minMember = 2;
					}
					modelMap.put(ENV_LIST, envList);
					modelMap.put("envCount", envCount);
					
					if((Integer)tenderFields.get(0)[1] == 0){
						isDecrypterReq = 0;
					}
				}
				modelMap.put(IS_DECRYPTER_REQ,isDecrypterReq);
					if(committeeType==1){	//opening committee
						if(isTWoStageOpening==1){
							minMember=2;
							validationMsgFlag=1;
						}
					}else if(committeeType==2){ //evaluation committee
						minMember=1;
					}
				 
					List<TblDepartment> tblDepartments = userService.getParentDepartments();
			    	json.append("{\"value\":\"0\",\"label\":\"Please select\"}").append(",");
					if(tblDepartments!=null && !tblDepartments.isEmpty()){
						for (TblDepartment tblDepartment : tblDepartments) {
							json.append("{\"value\":\""+tblDepartment.getDeptId()+"\",\"label\":\""+tblDepartment.getDeptName()+"\"}").append(",");
						}
					}
					jsonStr = json.toString().replaceAll(",$", "");
					jsonStr=jsonStr+"]";
					grandParentDeptJson=getGrandParentDeptList();
				    modelMap.addAttribute("deptLst", jsonStr);	
				    modelMap.put("minMember", minMember);
				    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
				    modelMap.addAttribute("grandParentDeptId", sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
			}
		} catch (Exception e) {
			return exceptionHandlerService.writeLog(e);			
		}
		finally{
			
		}
		return "etender/buyer/CreateTecToc";
	}
	
	@RequestMapping(value="/buyer/addcommittee", method=RequestMethod.POST)
	public String addCommittee(HttpServletRequest request, RedirectAttributes redirectAttributes,HttpSession session){
		String redirect = "";
		String redirectMsg = null;
		String redirectFailMsg = null;
		int tenderId = 0;
		int committeeType = 0;
		int isStandard = 0;
		int createdBy = 0;
		int memberCount = 0;
		int envelopeCount = 0;
		int committeeId = 0;
		boolean isSuccess = false;
		int isTECTOCSame=0;
		List<TblCommitteeUser> tblCommitteeUserList = new ArrayList<TblCommitteeUser>();
		SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
		try {
			if(sessionBean!=null) {
				createdBy = 1;
				tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
				committeeType = StringUtils.hasLength(request.getParameter("hdCommitteeTypeId")) ? Integer.parseInt(request.getParameter("hdCommitteeTypeId")) : 0;
				envelopeCount = StringUtils.hasLength(request.getParameter("hdEnvCount")) ? Integer.parseInt(request.getParameter("hdEnvCount")) : 0;
				memberCount = StringUtils.hasLength(request.getParameter("memberCount")) ? Integer.parseInt(request.getParameter("memberCount")) : 0;
				isTECTOCSame = StringUtils.hasLength(request.getParameter("isTECTOCSame")) ? Integer.parseInt(request.getParameter("isTECTOCSame")) : 0;
				
				String committeeName = "";
				if(committeeType==1) {
					committeeName="Tender Opening committee";
				}else {
					committeeName="Tender Evaluation committee";
				}
                                
					TblCommittee tblCommittee = new TblCommittee();
					tblCommittee.setCommitteeName(committeeName);
					tblCommittee.setCommitteeType(committeeType);
					tblCommittee.setTblTender(new TblTender(tenderId));
					tblCommittee.setIsStandard(isStandard);
					tblCommittee.setRemarks("");
					tblCommittee.setCreatedBy(createdBy);
					tblCommittee.setIsActive(1);
					
					String[] officerIds = request.getParameterValues("hdOfficerId");
					String[] envelopeIds = request.getParameterValues("hdEnvelopeId");
					if(memberCount == officerIds.length){
						for (int i = 0; i < memberCount; i++) {
							int officerId = Integer.parseInt(officerIds[i]);
							int isDecryptor = 0;
							for (int j = 1; j <= envelopeCount; j++) {
								if(request.getParameter("envOpenMember_"+officerId+"_"+j+"") != null){
									TblCommitteeUser tblCommitteeUser = new TblCommitteeUser();
									tblCommitteeUser.setTblCommittee(tblCommittee);
									tblCommitteeUser.setTblOfficer(new TblOfficer(officerId));
									tblCommitteeUser.setChildId(Integer.parseInt(envelopeIds[j-1]));
									tblCommitteeUser.setIsDecryptor(isDecryptor);
									tblCommitteeUser.setEncryptionLevel(0);
									tblCommitteeUser.setRemarks("");
									tblCommitteeUser.setCreatedBy(createdBy);
									tblCommitteeUser.setIsApproved(0);
									tblCommitteeUser.setUserRoleId(0);
									tblCommitteeUserList.add(tblCommitteeUser);
							}
							}
						}
						
						List<TblCommitteeEnvelope> tblCommitteeEnvelopeList = new ArrayList<TblCommitteeEnvelope>();
						for(int k=0;k<envelopeIds.length;k++){
							TblCommitteeEnvelope tblCommitteeEnvelope = new TblCommitteeEnvelope();
							if(request.getParameter(MIN_APPROVAL_REQ+(k+1)) != null){
								tblCommitteeEnvelope.setTblCommittee(tblCommittee);
								tblCommitteeEnvelope.setTblTenderEnvelope(new TblTenderEnvelope(Integer.parseInt(envelopeIds[k])));
								tblCommitteeEnvelope.setMinMemberApproval(Integer.parseInt(request.getParameter(MIN_APPROVAL_REQ+(k+1))));
								tblCommitteeEnvelopeList.add(tblCommitteeEnvelope);
							}
						}
						
						isSuccess = committeeFormationService.addCommittee(tblCommittee, tblCommitteeUserList, tblCommitteeEnvelopeList, committeeType, 0);
						if(isSuccess){
							committeeId = tblCommittee.getCommitteeId();
							if(isTECTOCSame==1) {
								dumnTECfromTOC(tblCommittee, tblCommitteeUserList, tblCommitteeEnvelopeList, (int)sessionBean.getUserId());
							}	
							
							redirect = "etender/buyer/tenderDashboard/"+tenderId;
							if(committeeType == 1){
								redirectMsg  = "bid_opening_committee_create_successfully";
							}
							else if(committeeType == 2){ 
								redirectMsg  = "bid_evaluation_committee_create_successfully";
							}
							
						}
						else {
							redirect = redirect + "/" + tenderId +"/"+committeeType+"";
							redirectFailMsg = CommonKeywords.ERROR_MSG_KEY.toString();
						}
					}
			}else {
				redirect = "/notloggedin";	
			}
				
		} catch (Exception e) {
			return exceptionHandlerService.writeLog(e);
		}
		finally {
		}
		redirectAttributes.addFlashAttribute(isSuccess ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), isSuccess ? redirectMsg : redirectFailMsg);
		return "redirect:/" + redirect;
	}
	

    /**
     * 
     * @param tenderId
     * @param committeeType
     * @param linkId
     * @param request
     * @param modelMap
     * @return
     */
	@RequestMapping(value="/buyer/editcommittee/{tenderId}/{committeeType}/{linkId}", method=RequestMethod.GET)
	public String editCommittee(@PathVariable(TENDER_ID) Integer tenderId, @PathVariable(COMMITTEE_TYPE) Integer committeeType, @PathVariable("linkId") Integer linkId, HttpServletRequest request , ModelMap modelMap,HttpSession session){
		int envCount = 0;
		int committeeId = 0;
		String committeeName = null;
		int isApproved = 0;
		int minMember = 1;
	    int validationMsgFlag=0;
	    StringBuilder json = new StringBuilder("[");
	    String jsonStr = "";
	    String grandParentDeptJson="";
	    SessionBean sessionBean = null;
		try {			
			sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
			List<Object[]> committeeDetails = committeeFormationService.getCommitteeDetails(tenderId, committeeType, 0);
			committeeId = Integer.parseInt(committeeDetails.get(0)[0].toString());
			committeeName = committeeDetails.get(0)[1].toString();
			isApproved = Integer.parseInt(committeeDetails.get(0)[3].toString());
			modelMap.put("isEdit", true);
			grandParentDeptJson= getGrandParentDeptList();
			List<Object[]> tenderFields = tenderCommonService.getTenderFields(tenderId, "encryptionLevel,isCertRequired,isTwoStageEvaluation,multiLevelEvaluationReq,isTwoStageOpening,decryptorRequired");
			if(tenderFields != null && !tenderFields.isEmpty()){
				List<Object[]> envList = committeeFormationService.getTenderEnvelopesDetails(tenderId);
				if(envList != null && !envList.isEmpty()){
					envCount = envList.size();
					modelMap.put("envCount", envCount);
					modelMap.put(ENV_LIST, envList);
				}
			}
//			modelMap.put("userDetails", committeeFormationService.getCommitteeUserDetails(tenderId, committeeId));
			modelMap.put("userEnvelopeDetails", committeeFormationService.getCommitteeUserEnvelopeDetails(committeeId));
			modelMap.put("userMinApproval", committeeFormationService.getCommitteeMinApproval(committeeId));
			modelMap.put("committeeId", committeeId);
			modelMap.put("committeeName", committeeName);
			modelMap.put("committeeUserDetails", committeeFormationService.getOfficerDtlOfCommitte(committeeId));
			modelMap.put("isApproved", isApproved);
			modelMap.put("operType", "Edit");
			
			if(tenderFields != null && !tenderFields.isEmpty()){
				if(committeeType==1){
					
				}else if(committeeType==2 && (Integer.parseInt(tenderFields.get(0)[3].toString())==1)){ //evaluation committee
					
				}else if(committeeType==2 && (Integer.parseInt(tenderFields.get(0)[2].toString())==1)){
					
				}
			}
			
			List<TblDepartment> tblDepartments = userService.getParentDepartments();
	    	json.append("{\"value\":\"0\",\"label\":\"Please select\"}").append(",");
			if(tblDepartments!=null && !tblDepartments.isEmpty()){
				for (TblDepartment tblDepartment : tblDepartments) {
					json.append("{\"value\":\""+tblDepartment.getDeptId()+"\",\"label\":\""+tblDepartment.getDeptName()+"\"}").append(",");
				}
			}
			jsonStr = json.toString().replaceAll(",$", "");
			jsonStr=jsonStr+"]";
			
		    modelMap.addAttribute("deptLst", jsonStr);	
			modelMap.put("minMember", minMember);
			modelMap.put("validationMsgFlag", validationMsgFlag);
			modelMap.put("linkId", linkId);
			modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
			modelMap.addAttribute("grandParentDeptId", sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		} catch (Exception e) {
			return exceptionHandlerService.writeLog(e);			
		}
		finally{
			
		}
		return "etender/buyer/CreateTecToc";
	}
	
	/**
	 * author bhavin.patel
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="/buyer/posteditcommittee", method=RequestMethod.POST)
	public String postEditCommittee(HttpServletRequest request, RedirectAttributes redirectAttributes){
		String redirect = "";
		String redirectSuccMsg = null;
		String redirectFailMsg = null;
		int tenderId = 0;
		int committeeType = 0;
		int committeeId = 0;
		int linkId = 0;
		boolean isSuccess = false;
		boolean isAllowEdit = true;
		boolean isEnvOpenEval = true;
		List<TblCommitteeUser> tblCommitteeUserList = new ArrayList<TblCommitteeUser>();
		try {
				tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
				committeeType = StringUtils.hasLength(request.getParameter("hdCommitteeTypeId")) ? Integer.parseInt(request.getParameter("hdCommitteeTypeId")) : 0;
				List<Object[]> envList = committeeFormationService.getTenderEnvelopesDetails(tenderId);
				
				if(isAllowEdit && isEnvOpenEval){
					int createdBy = 1;
					int envelopeCount = StringUtils.hasLength(request.getParameter("hdEnvCount")) ? Integer.parseInt(request.getParameter("hdEnvCount")) : 0;
					int memberCount = StringUtils.hasLength(request.getParameter("memberCount")) ? Integer.parseInt(request.getParameter("memberCount")) : 0;
					int isApproved = StringUtils.hasLength(request.getParameter("hdIsApproved")) ? Integer.parseInt(request.getParameter("hdIsApproved")) : 0;
					committeeId = StringUtils.hasLength(request.getParameter("hdCommitteId")) ? Integer.parseInt(request.getParameter("hdCommitteId")) : 0;
					linkId = StringUtils.hasLength(request.getParameter("hdLinkId")) ? Integer.parseInt(request.getParameter("hdLinkId")) : 0;
					TblCommittee tblCommittee = new TblCommittee();
						tblCommittee.setCommitteeId(committeeId);	
					String[] officerIds = request.getParameterValues("hdOfficerId");
					String[] envelopeIds = request.getParameterValues("hdEnvelopeId");
					if(memberCount == officerIds.length){
						List<TblCommitteeUser> tblCommitteeUserApprovals = committeeFormationService.getCommitteeUserApprovalDetails(committeeId, 1);
						if(tblCommitteeUserApprovals != null && !tblCommitteeUserApprovals.isEmpty()){
							for(TblCommitteeUser tblCommitteeUser : tblCommitteeUserApprovals){
								TblCommitteeUser tblCommitteeUser1 = new TblCommitteeUser();
								tblCommitteeUser1.setTblCommittee(tblCommittee);
								tblCommitteeUser1.setChildId(tblCommitteeUser.getChildId());
								tblCommitteeUser1.setIsDecryptor(tblCommitteeUser.getIsDecryptor());
								tblCommitteeUser1.setEncryptionLevel(tblCommitteeUser.getEncryptionLevel());
								tblCommitteeUser1.setRemarks(tblCommitteeUser.getRemarks());
								tblCommitteeUser1.setApprovedOn(tblCommitteeUser.getApprovedOn());
								tblCommitteeUser1.setApprovedBy(tblCommitteeUser.getApprovedBy());
								tblCommitteeUser1.setCreatedOn(tblCommitteeUser.getCreatedOn());
								tblCommitteeUser1.setCreatedBy(tblCommitteeUser.getCreatedBy());
								tblCommitteeUser1.setIsApproved(tblCommitteeUser.getIsApproved());
								tblCommitteeUser1.setTblOfficer(tblCommitteeUser.getTblOfficer());
								tblCommitteeUserList.add(tblCommitteeUser1);					
							}
						}
							
						for (int i = 0; i < memberCount; i++) {
							int officerId = Integer.parseInt(officerIds[i]);
							for (int j = 1; j <= envelopeCount; j++) {
								if(request.getParameter("envOpenMember_"+officerId+"_"+j+"") != null){
									TblCommitteeUser tblCommitteeUser = new TblCommitteeUser();
									if(request.getParameter("envOpenApproved_"+officerId+"_"+j+"") == null){
										tblCommitteeUser.setTblCommittee(tblCommittee);
										tblCommitteeUser.setChildId(Integer.parseInt(envelopeIds[j-1]));
										tblCommitteeUser.setIsDecryptor(0);
										tblCommitteeUser.setEncryptionLevel(0);
										tblCommitteeUser.setRemarks("");
										tblCommitteeUser.setCreatedBy(createdBy);
										tblCommitteeUser.setIsApproved(0);
										tblCommitteeUser.setUserRoleId(0);
										tblCommitteeUser.setTblOfficer(new TblOfficer(officerId));
										tblCommitteeUserList.add(tblCommitteeUser);	
									}
								}
							}
						}
						
						List<TblCommitteeEnvelope> tblCommitteeEnvelopeList = new ArrayList<TblCommitteeEnvelope>();
						for(int k=0;k<envelopeIds.length;k++){
							TblCommitteeEnvelope tblCommitteeEnvelope = new TblCommitteeEnvelope();
							if(request.getParameter(MIN_APPROVAL_REQ+(k+1)) != null){
								tblCommitteeEnvelope.setTblCommittee(tblCommittee);
								tblCommitteeEnvelope.setTblTenderEnvelope(new TblTenderEnvelope(Integer.parseInt(envelopeIds[k])));
								tblCommitteeEnvelope.setMinMemberApproval(Integer.parseInt(request.getParameter(MIN_APPROVAL_REQ+(k+1))));
								tblCommitteeEnvelopeList.add(tblCommitteeEnvelope);
							}
						}
							isSuccess = committeeFormationService.addCommittee(tblCommittee, tblCommitteeUserList, tblCommitteeEnvelopeList, committeeType, 1);
						if(isSuccess){
							redirect = "etender/buyer/tenderDashboard/"+tenderId;	
							if(committeeType == 1){
								redirectSuccMsg  = "bid_opening_committee_edit_successfully";
							}
							else if(committeeType == 2){ 
								redirectSuccMsg  = "bid_evaluation_committee_edit_successfully";
							}
						}
						else {
							redirect = redirect + "/" + tenderId +"/"+committeeType+"/"+linkId;
							redirectFailMsg = CommonKeywords.ERROR_MSG_KEY.toString();
						}
					}
				}
				else {
					redirect = redirect + "/" + tenderId +"/"+committeeType+"/"+linkId;
					if(!isAllowEdit){
						redirectFailMsg = "redirect_msg_bid_encrypted";
					}
				}
			
		} catch (Exception e) {
			return exceptionHandlerService.writeLog(e);
		}
		finally {
			
		}
		redirectAttributes.addFlashAttribute(isSuccess ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), isSuccess ? redirectSuccMsg : redirectFailMsg);
		return "redirect:/" + redirect;
	}
	
	
	
    
    /**
     * Method to view display create committee
     * @param tenderId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/buyer/getcreatecommitee/{tenderId}", method = RequestMethod.GET)
    public String getCreateCommitee(@PathVariable(TENDER_ID) int tenderId, ModelMap modelMap, HttpServletRequest request) {
    String 	grandParentDeptJson = "";
    SessionBean sessionBean = null;
	try {
		sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		if(sessionBean!=null) {
		grandParentDeptJson=getGrandParentDeptList();
		modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
		modelMap.addAttribute("grandParentDeptId", sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		}
	} catch (Exception ex) {
	    return exceptionHandlerService.writeLog(ex);
	} finally {
	}
	return "/etender/buyer/CreateCommitee";
    }
    
    @ResponseBody
    @RequestMapping(value = "/buyer/officers/{searchValue}/{keyword}", method = RequestMethod.POST)
    public String getOfficerList(@PathVariable("searchValue") String searchValue,@PathVariable("keyword") String keyword,ModelMap modelMap, HttpServletRequest request) {
    	StringBuilder json= new StringBuilder("[");
    	String jsonStr = "";
    	List<TblOfficer> lstTblOfficers = null;
    	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
	try {
		lstTblOfficers=committeeFormationService.getOfficerLst(keyword, searchValue,sessionBean);
		if(lstTblOfficers!=null && !lstTblOfficers.isEmpty()){
			for (TblOfficer tblOfficer : lstTblOfficers) {
				TblDepartment department = userService.getDepartmentById(tblOfficer.getTblDepartment().getDeptId());
				TblDesignation tblDesignation = userService.getDesignationById(tblOfficer.getTblDesignation().getDesignationId());
				json.append("{\"value\":\""+tblOfficer.getOfficername()+"@@"+tblOfficer.getEmailid()+"@@"+department.getDeptName()+"@@"+tblDesignation.getDesignationName()+"@@"+tblOfficer.getId()+"\",\"label\":\""+tblOfficer.getOfficername()+"("+tblOfficer.getEmailid()+")"+"\"}").append(",");
			}
		}
		 jsonStr = json.toString().replaceAll(",$", "");
		jsonStr=jsonStr+"]";
	} catch (Exception ex) {
	    return exceptionHandlerService.writeLog(ex);
	} finally {
	}
	return jsonStr;
    }

    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/buyer/geteditcommitee/{tenderId}/{committeeId}", method = RequestMethod.GET)
    public String getEditCommitee(@PathVariable(TENDER_ID) int tenderId, @PathVariable("committeeId") int comitteeId, ModelMap modelMap, HttpServletRequest request) {
    String 	grandParentDeptJson = "";
    List<Object[]> committeeDetailLst = new ArrayList<Object[]>();
    SessionBean sessionBean = null;
	try {
		sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		if(sessionBean!=null) {
	    Set<TblOfficer> committeeDetails = committeeFormationService.getAllCommitteeMemberDetails(comitteeId);
		for (TblOfficer tblOfficer : committeeDetails) {
			TblDepartment department = userService.getDepartmentById(tblOfficer.getTblDepartment().getDeptId());
			TblDesignation tblDesignation = userService.getDesignationById(tblOfficer.getTblDesignation().getDesignationId());
			committeeDetailLst.add(new Object[]{tblOfficer.getOfficername(),tblOfficer.getEmailid(),tblOfficer.getId(),department.getDeptName(),tblDesignation.getDesignationName()});
		}
		grandParentDeptJson=getGrandParentDeptList();
		modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
	    modelMap.addAttribute("operType", "Edit");
	    modelMap.addAttribute("committeeDetails", committeeDetailLst);
	    modelMap.addAttribute("committeeId", comitteeId);
	    modelMap.addAttribute("grandParentDeptId", sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		}
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} finally {
//	    auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), editCommitteeLinkId, getEditPrebidComittee, tenderId, comitteeId);
	}
	return "/etender/buyer/CreateCommitee";
    }

    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/buyer/getviewcommitee/{tenderId}/{committeeId}/{committeeType}", method = RequestMethod.GET)
    public String getVeiwCommitee(@PathVariable(TENDER_ID) int tenderId, @PathVariable("committeeId") int comitteeId,@PathVariable("committeeType") int committeeType, ModelMap modelMap, HttpServletRequest request) {
    	int envCount = 0;
    	List<Object[]> committeeDetailLst = new ArrayList<Object[]>();
	try {
	    Set<TblOfficer> committeeDetails = committeeFormationService.getAllCommitteeMemberDetails(comitteeId);
	    for (TblOfficer tblOfficer : committeeDetails) {
			TblDepartment department = userService.getDepartmentById(tblOfficer.getTblDepartment().getDeptId());
			TblDesignation tblDesignation = userService.getDesignationById(tblOfficer.getTblDesignation().getDesignationId());
			committeeDetailLst.add(new Object[]{tblOfficer.getOfficername(),tblOfficer.getEmailid(),tblOfficer.getId(),department.getDeptName(),tblDesignation.getDesignationName()});
		}
	    List<Object[]> tenderFields = tenderCommonService.getTenderFields(tenderId, "encryptionLevel,isCertRequired,isTwoStageEvaluation,multiLevelEvaluationReq,isTwoStageOpening,decryptorRequired");
		if(tenderFields != null && !tenderFields.isEmpty()){
			List<Object[]> envList = committeeFormationService.getTenderEnvelopesDetails(tenderId);
			if(envList != null && !envList.isEmpty()){
				envCount = envList.size();
				modelMap.put("envCount", envCount);
				modelMap.put(ENV_LIST, envList);
			}
		}
		Map<String,Boolean> userEnvlopMap = new HashMap<String, Boolean>();
		List<Object[]> lstUserEnvelopeData = committeeFormationService.getCommitteeUserEnvelopeDetails(comitteeId);
		if(lstUserEnvelopeData!=null && !lstUserEnvelopeData.isEmpty()) {
			for (Object[] objects : lstUserEnvelopeData) {
				String key = objects[0]+"_"+objects[1];
				userEnvlopMap.put(key, true);
			}
		}
		modelMap.put("userEnvelopeDetails", lstUserEnvelopeData);
		modelMap.put("userEnvlopMap", userEnvlopMap);
	    modelMap.addAttribute("committeeDetails", committeeDetailLst);
	    modelMap.addAttribute("committeeId", comitteeId);
	    modelMap.addAttribute("committeeType", committeeType);
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} finally {
//	    auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), editCommitteeLinkId, getEditPrebidComittee, tenderId, comitteeId);
	}
	return "/etender/buyer/ViewCommitee";
    }
    
    
    
    
    /**
     * Method to post committee details for both create and edit
     * @param request
     * @return
     */
    @RequestMapping(value = "/buyer/submitprebidcomittee", method = RequestMethod.POST)
    public String submitPrebidComittee(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	HttpSession session = request.getSession();
	String retVal = "";
	boolean isSuccess = false;
	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
	int tenderId = 0;
    StringBuilder retValue = new StringBuilder();
    tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
	int committeeId = 0;
	boolean isEdit = false;
	TblCommittee tblCommittee = null;
	String redirectMsg = "redirect_success_prebid_comittee";
	retValue.append("etender/buyer/tenderDashboard/").append(tenderId); 
	
	try {
        List<TblCommitteeUser> tblcommitteeusers = new ArrayList<TblCommitteeUser>();
        String officerIds[];
        officerIds = request.getParameterValues("hdofficerId");
	    if ((officerIds != null)) {
		committeeId = StringUtils.hasLength(request.getParameter("hdCommitteId")) ? Integer.parseInt(request.getParameter("hdCommitteId")) : 0;
		isEdit = committeeId != 0;
		if (!isEdit) {
		    tblCommittee = new TblCommittee();
		    tblCommittee.setCommitteeName("PrebidCommitte");
		    tblCommittee.setCommitteeType(3);
		    tblCommittee.setTblTender(committeeFormationService.getTenderMaster(tenderId));
		    tblCommittee.setIsStandard(0);
		    tblCommittee.setRemarks("");
		    tblCommittee.setCreatedBy(1);
		    tblCommittee.setIsActive(1);
		    tblCommittee.setIsApproved(0);
		}
		int count = 0;
		    for (count = 0; count < officerIds.length; count++) {
			TblCommitteeUser tblCommitteeUser = new TblCommitteeUser();
			tblCommitteeUser.setTblCommittee(isEdit ? new TblCommittee(committeeId) : tblCommittee);
			tblCommitteeUser.setTblOfficer(new TblOfficer(Integer.parseInt(officerIds[count])));
			tblCommitteeUser.setChildId(0);
			tblCommitteeUser.setIsDecryptor(0);
			tblCommitteeUser.setEncryptionLevel(count);
			tblCommitteeUser.setRemarks("");
			tblCommitteeUser.setCreatedBy(1);
			tblCommitteeUser.setIsApproved(0);
			tblcommitteeusers.add(tblCommitteeUser);
		    }
		if (isEdit) {
		    isSuccess = committeeFormationService.updateRemoveCommitteeMembers(committeeId,tblcommitteeusers);
		    redirectMsg = "redirect_success_editprebid_comittee";
		    redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(),"pre_bid_committee_edit_successfully");
		} else {
		    isSuccess = committeeFormationService.addTblCommitteeMember(tblCommittee, tblcommitteeusers);
		    committeeId = tblCommittee.getCommitteeId();
		    redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(),"pre_bid_committee_create_successfully");
		}
		if (isSuccess) {
                retVal = retValue.toString();
		}
		
	    }
	} catch (Exception ex) {
	    retVal = exceptionHandlerService.writeLog(ex);
	} finally {
	}
	return  "redirect:/" + retVal;
    }
    
    
    /**
     * Method to view edit committee details page
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/buyer/gettendertabcontent/{tenderId}/{tabId}", method = RequestMethod.GET)
    public String getTenderTabContent(@PathVariable(TENDER_ID) int tenderId,@PathVariable("tabId") int tabId, ModelMap modelMap, HttpServletRequest request) {
    	String retVal="/etender/buyer/TenderPrebidTab";
	try {
	    boolean isCommitteeCreated = committeeFormationService.isPrebidCommitteeCreated(tenderId);
	    TblTender tblTender = committeeFormationService.getTenderMaster(tenderId);
	    modelMap.addAttribute("isCommitteeCreated", isCommitteeCreated);
	    modelMap.addAttribute("tblTender", tblTender);
	    if(tabId==3) {
	    	int prebidCommitteeId = committeeFormationService.getCommitteeId(tenderId, 3);
	    	Object[] prebidDtls = tenderCommonService.getTenderPrebidDetailByTenderId(tenderId);
	    	if(prebidDtls!=null){
	    		modelMap.put("prebidstartdate", commonService.convertSqlToClientDate(client_dateformate_hhmm, prebidDtls[2].toString()));
	    		modelMap.put("prebidenddate", commonService.convertSqlToClientDate(client_dateformate_hhmm, prebidDtls[3].toString()));
	    	}
	    	modelMap.put("isCommitteeCreated", prebidCommitteeId!=0);
	    	modelMap.put("prebidDtls", prebidDtls);
	    	modelMap.put("tenderId", tenderId);
	    	modelMap.put("objectId", tenderPrebidObjectId);
	    	modelMap.put("childId", prebidCommitteeId);
	    	modelMap.put("currentDate", commonService.getServerDateTime());
	    	modelMap.put("subChildId", 0);
	    	modelMap.put("otherSubChildId", 0);
	    	retVal="/etender/buyer/TenderPrebidTab";
	    }else if (tabId==2) {
	    	retVal="/etender/buyer/TenderEvaluationTab";
	    }else if(tabId==1) {
	    	retVal="/etender/buyer/TenderBidOpeningTab";
	    }
	    
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} finally {
//	    auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), editCommitteeLinkId, getEditPrebidComittee, tenderId, comitteeId);
	}
	return retVal;
    }
    
    
    /**
     * Method to view edit committee details page
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/buyer/publishprebidmom", method = RequestMethod.POST)
    public String publishPrebidMom(ModelMap modelMap, HttpServletRequest request,RedirectAttributes redirectAttributes) {
    String retVal="";
    int prebidCommitteeId = 0;
    int tenderId = 0;
	try {
		prebidCommitteeId = StringUtils.hasLength(request.getParameter("hdPrebidCommitteeId")) ? Integer.parseInt(request.getParameter("hdPrebidCommitteeId")) : 0;
		tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
	    	Object[] prebidDtls = tenderCommonService.getTenderPrebidDetailByTenderId(tenderId);
	    	committeeFormationService.publishPrebidMOM(tenderId, Integer.parseInt(tenderPrebidObjectId), prebidCommitteeId);
	    	if(prebidDtls!=null){
	    		modelMap.put("prebidstartdate", commonService.convertSqlToClientDate(client_dateformate_hhmm, prebidDtls[2].toString()));
	    		modelMap.put("prebidenddate", commonService.convertSqlToClientDate(client_dateformate_hhmm, prebidDtls[3].toString()));
	    	}
	    	modelMap.put("isCommitteeCreated", prebidCommitteeId!=0);
	    	modelMap.put("prebidDtls", prebidDtls);
	    	modelMap.put("tenderId", tenderId);
	    	modelMap.put("objectId", tenderPrebidObjectId);
	    	modelMap.put("childId", prebidCommitteeId);
	    	modelMap.put("currentDate", commonService.getServerDateTime());
	    	modelMap.put("subChildId", 0);
	    	modelMap.put("otherSubChildId", 0);
	    	modelMap.put(CommonKeywords.SUCCESS_MSG.toString(),"pre_bid_mom_publish_successfully");
	    	retVal="/etender/buyer/TenderPrebidTab";
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	}
	return retVal;
    }
    
    
    private String getGrandParentDeptList() {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<TblDepartment> tblDepartments = userService.getGrandParentDepartments();
				json.append("{\"value\":\"\",\"label\":\"Please select\"}").append(",");
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
    
    /**
     * 
     * @param committee
     * @param committeeUser
     * @param tblCommitteeEnvelope
     * @param userId
     * @return
     * @throws Exception
     */
    private void dumnTECfromTOC(TblCommittee committee,List<TblCommitteeUser> committeeUser,List<TblCommitteeEnvelope> tblCommitteeEnvelope,int userId) throws Exception {
    	TblCommittee evalTblCommittee=new TblCommittee();
    	List<TblCommitteeUser> evalTblCommitteeUserLst=new ArrayList<TblCommitteeUser>();
    	List<TblCommitteeEnvelope> evalTblCommitteeEnvelopeLst=new ArrayList<TblCommitteeEnvelope>();
    	
    	evalTblCommittee.setCommitteeName("Tender Evaluation committee");
    	evalTblCommittee.setCommitteeType(2);
    	evalTblCommittee.setCreatedBy(userId);
    	evalTblCommittee.setCreatedOn(commonService.getServerDateTime());
    	evalTblCommittee.setIsActive(committee.getIsActive());
    	evalTblCommittee.setIsApproved(committee.getIsApproved());
    	evalTblCommittee.setIsStandard(committee.getIsStandard());
    	evalTblCommittee.setTblTender(committee.getTblTender());
    	
    	for (TblCommitteeEnvelope tblCommitteeEnvelope2 : tblCommitteeEnvelope) {
    		TblCommitteeEnvelope evalTblCommitteeEnvelope = new TblCommitteeEnvelope();
    		evalTblCommitteeEnvelope.setMinMemberApproval(tblCommitteeEnvelope2.getMinMemberApproval());
    		evalTblCommitteeEnvelope.setTblTenderEnvelope(tblCommitteeEnvelope2.getTblTenderEnvelope());
    		evalTblCommitteeEnvelope.setTblCommittee(evalTblCommittee);
    		evalTblCommitteeEnvelopeLst.add(evalTblCommitteeEnvelope);
		}
    	
    	for (TblCommitteeUser tblCommitteeUser : committeeUser) {
    		TblCommitteeUser evalTblCommitteeUser = new TblCommitteeUser();
    		evalTblCommitteeUser.setApprovedBy(tblCommitteeUser.getApprovedBy());
    		evalTblCommitteeUser.setApprovedOn(tblCommitteeUser.getApprovedOn());
    		evalTblCommitteeUser.setChildId(tblCommitteeUser.getChildId());
    		evalTblCommitteeUser.setCreatedBy(tblCommitteeUser.getCreatedBy());
    		evalTblCommitteeUser.setCreatedOn(commonService.getServerDateTime());
    		evalTblCommitteeUser.setEncryptionLevel(0);
    		evalTblCommitteeUser.setIsApproved(tblCommitteeUser.getIsApproved());
    		evalTblCommitteeUser.setIsDecryptor(0);
    		evalTblCommitteeUser.setRemarks(tblCommitteeUser.getRemarks());
    		evalTblCommitteeUser.setTblCommittee(evalTblCommittee);
    		evalTblCommitteeUser.setTblOfficer(tblCommitteeUser.getTblOfficer());
    		evalTblCommitteeUser.setUserRoleId(tblCommitteeUser.getUserRoleId());
    		evalTblCommitteeUserLst.add(evalTblCommitteeUser);
		}
    	committeeFormationService.dumpTOCtoTEC(evalTblCommittee, evalTblCommitteeUserLst, evalTblCommitteeEnvelopeLst, 2, 0);
    }
    
}
