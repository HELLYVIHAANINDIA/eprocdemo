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
import com.eprocurement.common.daointerface.TblBidderDao;
import com.eprocurement.common.daointerface.TblBidderSectorMappingDao;
import com.eprocurement.common.daointerface.TblCompanyDao;
import com.eprocurement.common.daointerface.TblDepartmentDao;
import com.eprocurement.common.daointerface.TblDesignationDao;
import com.eprocurement.common.daointerface.TblLinkDao;
import com.eprocurement.common.daointerface.TblMailMessageDao;
import com.eprocurement.common.daointerface.TblOfficerDao;
import com.eprocurement.common.daointerface.TblRoleLinkMappingDao;
import com.eprocurement.common.daointerface.TblUserLoginDao;
import com.eprocurement.common.daointerface.TblUserRoleMappingDao;
import com.eprocurement.common.model.TblCategoryMap;
import com.eprocurement.common.model.TblCurrencyMap;
import com.eprocurement.common.model.TblMailMessage;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblBidderSectorMapping;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblDesignation;
import com.eprocurement.etender.model.TblLink;
import com.eprocurement.etender.model.TblOfficer;
import com.eprocurement.etender.model.TblRoleLinkMapping;
import com.eprocurement.etender.model.TblUserLogin;
import com.eprocurement.etender.model.TblUserRoleMapping;

/**
 *
 */
@Service
public class OfficerService {

	@Autowired
	HibernateQueryDao hibernateQueryDao;
	@Autowired
	TblDepartmentDao tblDepartmentDao;
	@Autowired
	TblDesignationDao tblDesignationDao ;
	@Autowired
	TblOfficerDao tblOfficerDao ;
	@Autowired
	TblUserLoginDao tblUserLoginDao ;
	@Autowired
	TblUserRoleMappingDao tblUserRoleMappingDao ;
	@Autowired
	CommonDAO commonDAO;
	@Autowired
	CommonService commonService;
	@Autowired
	TblBidderDao tblBidderDao;
	@Autowired
	TblLinkDao tblLinkDao;
	@Autowired
	TblMailMessageDao tblMailMessageDao;
	@Autowired
	TblRoleLinkMappingDao tblRoleLinkMappingDao;
	@Autowired
	TblBidderSectorMappingDao tblBidderSectorMappingDao ;
	@Autowired
	TblCompanyDao tblCompanyDao;

	public static Map<String,List<Map<String,Object>>> notificationData = new HashMap<String,List<Map<String,Object>>>();
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<TblDepartment> getDepartments() throws Exception {
		List<TblDepartment> tblDepartmentLSt = null;
		tblDepartmentLSt = tblDepartmentDao.findEntity();
		return tblDepartmentLSt;
	}

	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<TblDepartment> getParentDepartments() throws Exception {
		List<TblDepartment> tblDepartmentLSt = null;
		tblDepartmentLSt = tblDepartmentDao.findTblDepartment("parentDeptId",Operation_enum.EQ,0,"grandParentDeptId",Operation_enum.NE,0);
		return tblDepartmentLSt;
	}
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<TblDepartment> getParentDepartmentsByGrandDept(int grandParentId) throws Exception {
		List<TblDepartment> tblDepartmentLSt = null;
		tblDepartmentLSt = tblDepartmentDao.findTblDepartment("grandParentDeptId",Operation_enum.EQ,grandParentId);
		return tblDepartmentLSt;
	}
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<TblDepartment> getGrandParentDepartments() throws Exception {
		List<TblDepartment> tblDepartmentLSt = null;
		tblDepartmentLSt = tblDepartmentDao.findTblDepartment("parentDeptId",Operation_enum.EQ,0,"grandParentDeptId",Operation_enum.EQ,0,"cstatus",Operation_enum.EQ,1);
		return tblDepartmentLSt;
	}
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<TblDesignation> getDesignations() throws Exception {
		List<TblDesignation> tblDesignationLSt = null;
		tblDesignationLSt = tblDesignationDao.findEntity();
		return tblDesignationLSt;
	}
	
	/**
	 * 
	 * @param deptId
	 * @return
	 * @throws Exception
	 */
	public TblDepartment getDepartmentById(int deptId) throws Exception {
		TblDepartment tblDepartment = null;
		List<TblDepartment> tblDepartmentLSt = tblDepartmentDao.findTblDepartment("deptId",Operation_enum.EQ,deptId);
		if(tblDepartmentLSt !=null && !tblDepartmentLSt.isEmpty()) {
			tblDepartment = tblDepartmentLSt.get(0);
		}
		return tblDepartment;
	}
	
	/**
	 * 
	 * @param deptId
	 * @return
	 * @throws Exception
	 */
	public TblDesignation getDesignationById(int designationId) throws Exception {
		TblDesignation tblDesignation = null;
		List<TblDesignation> tblDesignationLst = tblDesignationDao.findTblDesignation("designationId",Operation_enum.EQ,designationId);
		if(tblDesignationLst !=null && !tblDesignationLst.isEmpty()) {
			tblDesignation = tblDesignationLst.get(0);
		}
		return tblDesignation;
	}
	
	/**
	 * 
	 * @param deptId
	 * @return
	 * @throws Exception
	 */
	public List<TblDesignation> getDesignationBydeptId(int deptId) throws Exception {
		List<TblDesignation> tblDesignationLst = tblDesignationDao.findTblDesignation("deptId",Operation_enum.EQ,deptId);
		return tblDesignationLst;
	}
	
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isDepartmentNameExists(String deptName,int grandParentId) throws Exception {
		boolean isDepartmentExist = false;
		List<TblDepartment> tblDepartmentLSt = tblDepartmentDao.findTblDepartment("deptName",Operation_enum.EQ,deptName,"grandParentDeptId",Operation_enum.EQ,grandParentId);
		if(tblDepartmentLSt !=null && !tblDepartmentLSt.isEmpty()) {
			isDepartmentExist = true;
		}
		return isDepartmentExist;
	}
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isSubDepartmentNameExists(String deptName,int parentDeptId) throws Exception {
		boolean isDepartmentExist = false;
		List<TblDepartment> tblDepartmentLSt = tblDepartmentDao.findTblDepartment("deptName",Operation_enum.EQ,deptName,"parentDeptId",Operation_enum.EQ,parentDeptId);
		if(tblDepartmentLSt !=null && !tblDepartmentLSt.isEmpty()) {
			isDepartmentExist = true;
		}
		return isDepartmentExist;
	}
	
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isEmailIdExists(String emailId) throws Exception {
		boolean isEmailIdExist = false;
		List<TblUserLogin> tblUserLogins = tblUserLoginDao.findTblUserLogin("loginid",Operation_enum.EQ,emailId,"cstatus",Operation_enum.IN,new Integer[]{1,0});
		if(tblUserLogins !=null && !tblUserLogins.isEmpty()) {
			isEmailIdExist = true;
		}
		return isEmailIdExist;
	}
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isCompanyExists(String company,String type) throws Exception {
		boolean isCompanyExist = false;
		if(type.equals("bidder")) {
			List<TblBidder> tblBidders = tblBidderDao.findTblBidder("companyName",Operation_enum.EQ,company,"cstatus",Operation_enum.IN,new Integer[]{1,0});
			if(tblBidders !=null && !tblBidders.isEmpty()) {
				isCompanyExist = true;
			}
		}else if(type.equals("department")) {
			List<TblDepartment> tblDepartments = tblDepartmentDao.findTblDepartment("deptName",Operation_enum.EQ,company,"cstatus",Operation_enum.IN,new Integer[]{1,0});
			if(tblDepartments !=null && !tblDepartments.isEmpty()) {
				isCompanyExist = true;
			}
		}
		return isCompanyExist;
	}
	
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isCompanyRegNoExists(String comapnyRegNo,String type) throws Exception {
		boolean isCompanyRegNoExist = false;
		if(type.equals("bidder")) {
			List<TblBidder> tblBidders = tblBidderDao.findTblBidder("commercialRegNo",Operation_enum.EQ,comapnyRegNo,"cstatus",Operation_enum.IN,new Integer[]{1,0});
			if(tblBidders !=null && !tblBidders.isEmpty()) {
				isCompanyRegNoExist = true;
			}
		}else if(type.equals("department")) {
			List<TblDepartment> tblDepartments = tblDepartmentDao.findTblDepartment("commercialRegNo",Operation_enum.EQ,comapnyRegNo,"cstatus",Operation_enum.IN,new Integer[]{1,0});
			if(tblDepartments !=null && !tblDepartments.isEmpty()) {
				isCompanyRegNoExist = true;
			}
		}
		return isCompanyRegNoExist;
	}
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public List<TblDepartment> getSubDepartments(int parentDeptId,String deptLevel) throws Exception {
		List<TblDepartment> tblDepartmentLSt =null; 
		if(deptLevel.equalsIgnoreCase("1")) {
			tblDepartmentLSt = tblDepartmentDao.findTblDepartment("parentDeptId",Operation_enum.EQ,parentDeptId);
		}else if(deptLevel.equalsIgnoreCase("0")){
			tblDepartmentLSt = tblDepartmentDao.findTblDepartment("grandParentDeptId",Operation_enum.EQ,parentDeptId,"parentDeptId",Operation_enum.EQ,0);
		}
		return tblDepartmentLSt;
	}
	
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isDesignationExists(String designationName,Integer[] deptId) throws Exception {
		boolean isDesignationExist = false;
		List<TblDesignation> tblDesignationLSt = tblDesignationDao.findTblDesignation("designationName",Operation_enum.EQ,designationName,"deptId",Operation_enum.IN,deptId);
		if(tblDesignationLSt !=null && !tblDesignationLSt.isEmpty()) {
			isDesignationExist = true;
		}
		return isDesignationExist;
	}
	
	@Transactional
	public boolean addDepartment(TblDepartment tblDepartment,String type) {
		boolean bSuccess = false;
		if(type.equals("edit")) {
			tblDepartmentDao.saveOrUpdateEntity(tblDepartment);
		}else {
			if(tblDepartment.getParentDeptId()==null) {
				tblDepartment.setParentDeptId(0);
			}
			tblDepartmentDao.addTblDepartment(tblDepartment);
		}
		
		bSuccess = true;
		return bSuccess;
	}
	
	@Transactional
	public boolean addOrganization(TblDepartment tblDepartment,List<TblBidderSectorMapping> tblBidderSectorMappings) {
		boolean bSuccess = false;
		List<TblBidderSectorMapping> tblBidderSectorMappingsTemp = new ArrayList<TblBidderSectorMapping>();
		tblDepartmentDao.addTblDepartment(tblDepartment);
		for (TblBidderSectorMapping bidderSectorMapping : tblBidderSectorMappings) {
			bidderSectorMapping.setBidderId(tblDepartment.getDeptId());
			tblBidderSectorMappingsTemp.add(bidderSectorMapping);
		}
		//to prevent concurrent modification error
		tblBidderSectorMappings.clear();
		tblBidderSectorMappings.addAll(tblBidderSectorMappingsTemp);
		tblBidderSectorMappingDao.saveUpdateAllTblBidderSectorMapping(tblBidderSectorMappings);
		bSuccess = true;
		return bSuccess;
	}
	
	
	@Transactional
	public boolean addDesignation(TblDesignation tblDesignation,String type) {
		boolean bSuccess = false;
		if(type.equals("edit")) {
			tblDesignationDao.saveOrUpdateEntity(tblDesignation);
		}else {
			tblDesignationDao.addTblDesignation(tblDesignation);
		}
		bSuccess = true;
		return bSuccess;
	}
	
	@Transactional
	public List<TblBidderSectorMapping> getSectorMappingById(int Id) throws Exception {
		boolean bSuccess = false;
		List<TblBidderSectorMapping> bidderSectorMappings = tblBidderSectorMappingDao.findTblBidderSectorMapping("bidderId",Operation_enum.EQ,Id);
		return bidderSectorMappings;
	}
	
	@Transactional
	public String getSectorNameById(int sectorId) throws Exception {
		String sectorName = "";
		Map<String,Object> column = new HashMap<String, Object>();
		column.put("SectorMst_Pk", sectorId);
		String query = "SELECT SectorMst_Pk,SecM_SectorName FROM sectormst_tbl where SectorMst_Pk=:SectorMst_Pk ";
		List<Object[]> list = commonDAO.executeSqlSelect(query, column);
    	if(list!=null && !list.isEmpty()) {
    		sectorName = list.get(0)[1].toString();
    	}
		return sectorName;
	}
	
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public boolean addUser(TblOfficer tblOfficer,TblUserLogin tblUserLogin,List<TblUserRoleMapping> tblUserRoleMappings,String type) {
		boolean bSuccess = false;
		List<TblUserRoleMapping> tblUserRoleMappingsTemp = new ArrayList<TblUserRoleMapping>();
		if(type.equals("edit")) {
			
			tblUserLoginDao.saveOrUpdateEntity(tblUserLogin);
			tblOfficer.setTblUserlogin(tblUserLogin);
			tblOfficerDao.saveOrUpdateEntity(tblOfficer);
			for (TblUserRoleMapping tblUserRoleMapping : tblUserRoleMappings) {
				tblUserRoleMapping.setTblUserlogin(tblUserLogin);
				tblUserRoleMappingsTemp.add(tblUserRoleMapping);
			}
			//to prevent concurrent modification error
			tblUserRoleMappings.clear();
			tblUserRoleMappings.addAll(tblUserRoleMappingsTemp);
			if(deletUserRolemapping(tblUserLogin)) {
				tblUserRoleMappingDao.saveUpdateAllTblUserRoleMapping(tblUserRoleMappings);
			}
		}else {
			tblUserLoginDao.addTblUserLogin(tblUserLogin);
			tblOfficer.setTblUserlogin(tblUserLogin);
			tblOfficerDao.addTblOfficer(tblOfficer);
			for (TblUserRoleMapping tblUserRoleMapping : tblUserRoleMappings) {
				tblUserRoleMapping.setTblUserlogin(tblUserLogin);
				tblUserRoleMappingsTemp.add(tblUserRoleMapping);
			}
			
			//to prevent concurrent modification error
			tblUserRoleMappings.clear();
			tblUserRoleMappings.addAll(tblUserRoleMappingsTemp);
			tblUserRoleMappingDao.saveUpdateAllTblUserRoleMapping(tblUserRoleMappings);
		}
		bSuccess = true;
		return bSuccess;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public boolean addBidder(TblBidder tblBidder,TblUserLogin tblUserLogin,TblCompany tblCompany ,String type,TblUserRoleMapping tblUserRoleMapping,List<TblBidderSectorMapping> tblBidderSectorMappings) {
		boolean bSuccess = false;
		List<TblBidderSectorMapping> tblBidderSectorMappingsTemp = new ArrayList<TblBidderSectorMapping>();
		if(type.equals("edit")) {
			tblUserLoginDao.saveOrUpdateEntity(tblUserLogin);
			tblBidder.setTblUserlogin(tblUserLogin);
			tblCompanyDao.saveOrUpdateEntity(tblCompany);
			tblBidder.setTblCompany(tblCompany);
			tblUserRoleMapping.setTblUserlogin(tblUserLogin);
			tblBidderDao.saveOrUpdateEntity(tblBidder);
			for (TblBidderSectorMapping bidderSectorMapping : tblBidderSectorMappings) {
				bidderSectorMapping.setBidderId(tblBidder.getBidderId());
				tblBidderSectorMappingsTemp.add(bidderSectorMapping);
			}
			//to prevent concurrent modification error
			tblBidderSectorMappings.clear();
			tblBidderSectorMappings.addAll(tblBidderSectorMappingsTemp);
			if(deletBidderSectorMapping(tblBidder)) {
				tblBidderSectorMappingDao.saveUpdateAllTblBidderSectorMapping(tblBidderSectorMappings);
			}
		}else {
			tblUserLoginDao.addTblUserLogin(tblUserLogin);
			tblBidder.setTblUserlogin(tblUserLogin);
			tblCompanyDao.addTblCompany(tblCompany);
			tblBidder.setTblCompany(tblCompany);
			tblBidderDao.addTblBidder(tblBidder);
			tblUserRoleMapping.setTblUserlogin(tblUserLogin);
			tblUserRoleMappingDao.addTblUserRoleMapping(tblUserRoleMapping);
			for (TblBidderSectorMapping bidderSectorMapping : tblBidderSectorMappings) {
				bidderSectorMapping.setBidderId(tblBidder.getBidderId());
				tblBidderSectorMappingsTemp.add(bidderSectorMapping);
			}
			//to prevent concurrent modification error
			tblBidderSectorMappings.clear();
			tblBidderSectorMappings.addAll(tblBidderSectorMappingsTemp);
			tblBidderSectorMappingDao.saveUpdateAllTblBidderSectorMapping(tblBidderSectorMappings);
		}
		bSuccess = true;
		return bSuccess;
	}
	
	@Transactional
	public Object[] getOfficerDetails(int officerId) {
		List<Object[]> officerDtls = null;
		Object[] officer = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("officerId",officerId);
        officerDtls = hibernateQueryDao.createNewQuery("select tblofficer.officername,tblofficer.mobileno,tblofficer.phoneNo,tbluserlogin.loginid,tbluserlogin.userId,tbluserlogin.password,tblofficer.tblDepartment.deptId,tblofficer.tblDesignation.designationId,tbluserlogin.timezoneId,tblofficer.countryid,tblofficer.stateid,tblofficer.city,tblofficer.address,tbluserlogin.isOrgenizationUser from TblOfficer tblofficer inner join tblofficer.tblUserlogin tbluserlogin where tblofficer.id =:officerId",var);
        if(officerDtls!=null && !officerDtls.isEmpty()) {
        	officer = officerDtls.get(0);
        }
        return officer;
	}
	
	@Transactional
	public Object[] getOfficerDetailsByUserId(int userId) {
		List<Object[]> officerDtls = null;
		Object[] officer = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("userId",userId);
        officerDtls = hibernateQueryDao.createNewQuery("select tblofficer.officername,tblofficer.mobileno,tblofficer.phoneNo,tbluserlogin.loginid,tbluserlogin.userId,tbluserlogin.password,tblofficer.tblDepartment.deptId,tblofficer.tblDesignation.designationId from TblOfficer tblofficer inner join tblofficer.tblUserlogin tbluserlogin where tbluserlogin.userId =:userId",var);
        if(officerDtls!=null && !officerDtls.isEmpty()) {
        	officer = officerDtls.get(0);
        }
        return officer;
	}
	
	
	@Transactional
	public Object[] getOfficerDetailsByDeptId(int deptId) {
		List<Object[]> officerDtls = null;
		Object[] officer = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("deptId",deptId);
        officerDtls = hibernateQueryDao.createNewQuery("select tblofficer.officername,tblofficer.id,tblofficer.mobileno,tblofficer.phoneNo,tblofficer.tblDepartment.deptId,tblofficer.tblDesignation.designationId from TblOfficer tblofficer inner join tblofficer.tblDepartment tblDepartment inner where tblDepartment.deptId =:deptId",var);
        if(officerDtls!=null && !officerDtls.isEmpty()) {
        	officer = officerDtls.get(0);
        }
        return officer;
	}
	
	/**
	 * 
	 * @param tblUserLogin
	 * @return
	 */
	public boolean deletUserRolemapping(TblUserLogin tblUserLogin) {
		Integer rowcnt = 0;
		StringBuilder strQuery = new StringBuilder();
        HashMap<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("userId", tblUserLogin.getUserId());
        strQuery.append("delete from TblUserRoleMapping where tblUserlogin.userId IN (:userId)");
        rowcnt = commonDAO.executeUpdate(strQuery.toString(), parameters);
		return rowcnt!=0;
	}
	
	
	/**
	 * 
	 * @param tblUserLogin
	 * @return
	 */
	@Transactional
	public boolean deletBidderSectorMapping(TblBidder tblBidder) {
		Integer rowcnt = 0;
		StringBuilder strQuery = new StringBuilder();
        HashMap<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("bidderId", tblBidder.getBidderId());
        strQuery.append("delete from TblBidderSectorMapping where bidderId IN (:bidderId)");
        rowcnt = commonDAO.executeUpdate(strQuery.toString(), parameters);
		return rowcnt!=0;
	}
	
	/**
	 * 
	 * @param bidderId
	 * @return
	 */
	@Transactional
	public Object[] getBiddderDetails(int bidderId) {
		
		List<Object[]> bidderDtls = null;
		Object[] bidderDtl = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("bidderId",bidderId);
        bidderDtls = hibernateQueryDao.createNewQuery("select tblBidder.emailId,tblBidder.personName,tblBidder.companyName,tblBidder.address,tblBidder.city,tblBidder.phoneno,tblBidder.mobileno,tblBidder.website,tblBidder.tblState.stateId,tblBidder.tblCountry.countryId,tblBidder.keyword,tblBidder.cstatus,tbluserlogin.userId,tbluserlogin.password,tblCompany.companyid,tblBidder.timezoneId,tblBidder.lastName,tblBidder.middleName,tblBidder.bidderDocId,tblBidder.addressline2,tblBidder.originCountryId,tblBidder.commercialRegNo,tblBidder.establishDate,tblBidder.postalAddressLine1,tblBidder.postalAddressLine2,tblBidder.postalStateId,tblBidder.postalCity,tblBidder.designationName,tblBidder.personalMobileNo,tblBidder.personalPhoneNo,tblBidder.registerType,tblBidder.postalStateId from TblBidder tblBidder inner join tblBidder.tblUserlogin tbluserlogin inner join tblBidder.tblCompany tblCompany  where bidderId=:bidderId",var);
        if(bidderDtls!=null && !bidderDtls.isEmpty()) {
        	bidderDtl = bidderDtls.get(0);
        }																														
        return bidderDtl;
	}
	
	/**
	 * 
	 * @param tblLink
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public boolean addLink(TblLink tblLink,String optType)
	{
		boolean bSuccess=false;
		if(optType.equalsIgnoreCase("edit")) {
			tblLinkDao.saveOrUpdateEntity(tblLink);
		}else {
			tblLinkDao.addTblLink(tblLink);
		}
		bSuccess=true;
		return bSuccess;
	}
	
	public TblMailMessage setTblMailMessage(Object... values){
		//To,From,Subject,Body,Description
		TblMailMessage tblMailMessage = new TblMailMessage();
		if(values[0]!=null){
			tblMailMessage.setMailTo(values[0].toString());	
		}else{
			tblMailMessage.setMailTo("");
		}
		if(values[1]!=null){
			tblMailMessage.setMailFrom(values[1].toString());
		}else{
			tblMailMessage.setMailFrom("");
		}
		if(values[2]!=null){
			tblMailMessage.setMailSubject(values[2].toString());
		}else{
			tblMailMessage.setMailSubject("");
		}
		if(values[3]!=null){
			tblMailMessage.setMailBody(values[3].toString());
		}else{
			tblMailMessage.setMailBody("");
		}
		tblMailMessage.setMailSent(0);
		if(values[4]!=null){
			tblMailMessage.setMailDescription(values[4].toString());
		}else{
			tblMailMessage.setMailDescription("");
		}
		
		return tblMailMessage;
	}
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public boolean addMail(TblMailMessage tblMailMessage){
		boolean bSuccess=false;
		tblMailMessageDao.addTblMailMessage(tblMailMessage);
		bSuccess=true;
		return bSuccess;
	}
	/**
	 * 
	 * @param linkId
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public TblLink getTblLinkById(int linkId) throws Exception {
		TblLink tblLink = null;
		List<TblLink> tblLinks = tblLinkDao.findTblLink("linkId",Operation_enum.EQ,linkId);
		if(tblLinks!=null && !tblLinks.isEmpty()) {
			tblLink = tblLinks.get(0);
		}
		return tblLink;
	}
	
	/**
	 * 
	 * @param deptName
	 * @return
	 * @throws Exception
	 */
	public boolean isLinkExists(String link) throws Exception {
		boolean isLinkExist = false;
		List<TblLink> tblLinkLSt = tblLinkDao.findTblLink("link",Operation_enum.EQ,link);
		if(tblLinkLSt !=null && !tblLinkLSt.isEmpty()) {
			isLinkExist = true;
		}
		return isLinkExist;
	}
	
	/**
	 * 
	 * @return
	 */
	@Transactional
	public List<TblLink> getTblLinks(){
		List<TblLink> tblLinks = null;
		tblLinks = tblLinkDao.getAllTblLink();
		return tblLinks;
	}
	
	/**
	 * 
	 * @param roleLinkMappings
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public boolean addRoleLinks(List<TblRoleLinkMapping> roleLinkMappings,int roleId) {
		boolean bSuccess = false;
		Integer rowcnt = 0;
		StringBuilder strQuery = new StringBuilder();
        HashMap<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("roleId", roleId);
        strQuery.append("delete from TblRoleLinkMapping  tblRoleLinkMapping where tblRoleLinkMapping.tblRoles.roleId=:roleId ");
        rowcnt = commonDAO.executeUpdate(strQuery.toString(), parameters);
		tblRoleLinkMappingDao.saveUpdateAllTblRoleLinkMapping(roleLinkMappings);
		bSuccess=true;
		return bSuccess;
	}
	
	@Transactional
	public List<TblRoleLinkMapping> getLinksByRoleId(int roleId) throws Exception{
		List<TblRoleLinkMapping> rolelinks = null;
		rolelinks=tblRoleLinkMappingDao.findTblRoleLinkMapping("tblRoles.roleId",Operation_enum.EQ,roleId);
		return rolelinks;		
	}
	
	
	@Transactional
	public String getDeptDetailByUserId(int officerId) throws Exception{
		StringBuilder deptDetail=new StringBuilder();
		List<TblOfficer>  tblOfficerLSt = tblOfficerDao.findTblOfficer("officerId",Operation_enum.EQ,officerId);
		if(tblOfficerLSt!=null && !tblOfficerLSt.isEmpty()){
			TblDepartment tblDepartment = tblOfficerLSt.get(0).getTblDepartment();
			int deptId = tblDepartment.getDeptId();
			deptDetail.append(tblDepartment.getGrandParentDeptId()).append(":").append(tblDepartment.getParentDeptId()).append(":").append(tblDepartment.getDeptId());
		}
		return deptDetail.toString();
	}
	
	
	/**
	 * 
	 * @param tblUserLogin
	 * @return
	 * @throws Exception 
	 */
	@Transactional
	public boolean updateBidderstatus(int bidderId,int userstatus,String remarks) throws Exception {
		Integer rowcnt = 0;
		StringBuilder strQuery = new StringBuilder();
		StringBuilder strQuery2 = new StringBuilder();
		TblBidder tblBidder = tblBidderDao.findTblBidder("bidderId",Operation_enum.EQ,bidderId).get(0);	
        HashMap<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("userId", tblBidder.getTblUserlogin().getUserId());
        parameters.put("cstatus", userstatus);
        strQuery.append("update TblUserLogin tblUserLogin set tblUserLogin.cstatus=:cstatus where tblUserLogin.userId=:userId ");
        rowcnt = commonDAO.executeUpdate(strQuery.toString(), parameters);
        HashMap<String, Object> bidderparameters = new HashMap<String, Object>();
        bidderparameters.put("bidderId", bidderId);
        bidderparameters.put("cstatus", userstatus);
        bidderparameters.put("remarks", remarks);
        strQuery2.append("update TblBidder tblBidder set tblBidder.cstatus=:cstatus,tblBidder.remarks=:remarks where tblBidder.bidderId=:bidderId ");
        rowcnt = commonDAO.executeUpdate(strQuery2.toString(), bidderparameters);
		return rowcnt!=0;
	}

	public List<Map<String,Object>> getNotificaitonCount( Integer marqueeTo, Integer tenderId) {
		List<Map<String,Object>> data = null;
		if(!notificationData.containsKey(marqueeTo+"_"+tenderId)){
			Map<String,Object> column = new HashMap<String, Object>();
			column.put("marqueeTo", marqueeTo);
			column.put("alias", "map");
			column.put("processId", 8);
			String query = "select count(1) as count from TblMarquee where isActive=1 and marqueeTo=:marqueeTo and tblProcess.processId!=:processId";
			if(tenderId != 0){
				column.put("tenderId", tenderId);
				query += " and tenderId=:tenderId";
			}
			data = commonDAO.executeSelect(query, column);
			notificationData.put(marqueeTo+"_"+tenderId,data);	 //will be cleat in tendercommonservice.
		}else{
			data = notificationData.get(marqueeTo+"_"+tenderId);;
		}
		return data;
	}

	public String updateNotificationStatus(Integer marqueeTo, Integer tenderId) {
		Map<String,Object> column = new HashMap<String, Object>();
		column.put("marqueeTo", marqueeTo);
		column.put("processId", 8);
		String query = "update TblMarquee set isActive=0 where isActive=1 and marqueeTo=:marqueeTo and tblProcess.processId!=:processId";
		if(tenderId != 0){
			column.put("tenderId", tenderId);
			query += " and tenderId=:tenderId";
		}
		commonDAO.executeUpdate(query, column);
		return "success";
	}
	/**
	 * 
	 * @param searchParam
	 * @param dataFromLevelx
	 * @return
	 */
	public List<Object[]> getCategoryData(String searchParam,String dataFromLevel) {
		String query = "";
		List <Object[]> result = null;
		Map<String,Object> column = new HashMap<String, Object>();
		column.put("unspscDesc", searchParam+"%");
		column.put("maxResult", 50);
		query = "select unspscId,unspscDesc from TblCategory where isActive=1 and unspscDesc like:unspscDesc";
		if(dataFromLevel.equals("4")){
			query += " and length(unspscId) > 6";
		}else if(dataFromLevel.equals("3,4")){
			query += " and length(unspscId) > 4";
		}
		result = commonDAO.executeSelect(query, column);
		return result;
	}

	public void saveCategoryData(int bidderId,Long userId, int tenderId,int corrigendumId, String categoryText) {
		// TODO Auto-generated method stub
		deleteOldCategory(userId,tenderId,corrigendumId);
		String keywords = "";
		String[] categoryList =  categoryText.split("#@#");
		List<TblCategoryMap> tblCategoryMapList = new ArrayList<TblCategoryMap>();
		for(String category : categoryList){
			String[] cat = category.split("###");
			TblCategoryMap tblCategory = new TblCategoryMap();
			tblCategory.setUserId((int) (long) userId);
			tblCategory.setTenderId(tenderId);
			tblCategory.setCategoryText(cat[1]);
			tblCategory.setCategoryCode(Integer.parseInt(cat[0]));
			tblCategory.setCorrigendumId(corrigendumId);
			tblCategoryMapList.add(tblCategory);
			keywords +=cat[1]+", ";
		}
		commonDAO.saveOrUpdateAll(tblCategoryMapList);
		Map<String,Object> column = new HashMap<String, Object>();
		if(tenderId == 0 && bidderId != 0){
			column.put("bidderId", bidderId);
			column.put("keyword", keywords);
			commonDAO.executeUpdate(" update TblBidder set keyword=:keyword where bidderId=:bidderId", column);
		}else if(tenderId != 0){
			column.put("tenderId", tenderId);
			column.put("keyword", keywords);
			commonDAO.executeUpdate(" update TblTender set keywordText=:keyword where tenderId=:tenderId", column);
		}
	}

	public void deleteOldCategory(Long userId, int tenderId,int corrigendumId) {
		String delete= "delete TblCategoryMap where ";
		delete += " userId="+userId +" and tenderId="+tenderId +" and corrigendumId="+corrigendumId;	
		commonDAO.executeUpdate(delete, null);
	}

	public List<Object[]> getCategoryMap(int userId, int tenderId,int corrigendumId) {
		return commonDAO.executeSelect(" select categoryCode,categoryText from TblCategoryMap where userId="+userId+" and tenderId="+tenderId+" and corrigendumId="+corrigendumId, null);
	}

	// update category from corrigenum to tender.
	public void updateCategoryToTender(int tenderId, int corrigendumId) {
		deleteOldCategory(0l, tenderId, 0);
		Map<String,Object> column = new HashMap<String, Object>();
		column.put("tenderId", tenderId);
		column.put("corrigendumId", corrigendumId);
		commonDAO.executeUpdate("update TblCategoryMap set tenderId=:tenderId ,corrigendumId=0 where corrigendumId=:corrigendumId", column);
	}
	/**
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<TblUserRoleMapping> getUserRoleMappingByUserId(long userId) throws Exception {
		List<TblUserRoleMapping> tblUserRoleMappings = tblUserRoleMappingDao.findTblUserRoleMapping("tblUserlogin.userId",Operation_enum.EQ,userId);
		return tblUserRoleMappings;
	}
	
	public TblUserLogin getTblUseloginbyUserId(long userId) throws Exception {
		TblUserLogin tblUserLogin = null;
		List<TblUserLogin> userLogins =  tblUserLoginDao.findTblUserLogin("userId",Operation_enum.EQ,userId);
		if(userLogins!=null && !userLogins.isEmpty()) {
			tblUserLogin = userLogins.get(0);
		}
		return tblUserLogin;
	}
	
	
	public TblOfficer getTblOfficerbyUserId(long officerId) throws Exception {
		TblOfficer tblOfficer = null;
		List<TblOfficer> tblOfficers =  tblOfficerDao.findTblOfficer("id",Operation_enum.EQ,officerId);
		if(tblOfficers!=null) {
			tblOfficer = tblOfficers.get(0);
		}
		return tblOfficer;
	}
	
	/**
	 * 
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	public TblCompany getCompanyById(int companyId) throws Exception {
		TblCompany tblCompany = null;
		List<TblCompany> tblCompanies = tblCompanyDao.findTblCompany("companyid",Operation_enum.EQ,companyId);
		if(tblCompanies!=null && !tblCompanies.isEmpty()) {
			tblCompany = tblCompanies.get(0);
		}
		return tblCompany;
	}

	public boolean updateCurrencyMap(SessionBean sessionBean, String[] currencyIds, Integer departmentId) {
		Map<String,Object> col = new HashMap<String, Object>();
		col.put("departmentId", departmentId);
		commonDAO.executeUpdate("delete TblCurrencyMap where departmentId=:departmentId", col);
		if(currencyIds != null && currencyIds.length > 0){
			List<TblCurrencyMap> tblCurrencyMapList = new ArrayList<TblCurrencyMap>();
			for(String currencyId : currencyIds){
				TblCurrencyMap tblCurrencyMap = new TblCurrencyMap();
				tblCurrencyMap.setDepartmentId(departmentId);
				tblCurrencyMap.setCurrencyId(Integer.parseInt(currencyId));
				tblCurrencyMap.setCreatedById(Integer.parseInt(sessionBean.getUserId()+""));
				tblCurrencyMap.setCreatedByDate(commonService.getServerDateTime());
				tblCurrencyMapList.add(tblCurrencyMap);
			}
			commonDAO.saveOrUpdateAll(tblCurrencyMapList);
		}
		return true;
	}
	
}