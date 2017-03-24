package com.eprocurement.etender.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "tbl_tenderworkflow")
public class TblTenderWorkflow implements java.io.Serializable {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "workflowId", unique = true, nullable = false)
    private Integer workflowId;
	@Column(name = "action")
    private String action;
	@Column(name = "remarks")
    private String remarks;
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="officerId")
    private TblOfficer tblOfficer;
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderId")
    private TblTender tblTender;
	@Column(name = "parentWorkflowId")
	private int parentWorkflowId;
	@Column(name = "cstatus")
    private int cstatus;	// 0 : workflow last entry, 1 : all previous entry will be 1, 2 :After approved status will be 2. 
	@Column(name = "createdById")
    private int createdById;
	@Column(name = "createdbyName")
	String createdbyName;
	@Column(name = "modifiedById")
    private int modifiedById;
	@Column(name = "modifiedByName")
    String modifiedByName;
	@Column(name = "createdDate")
    Date createdDate;
	@Column(name = "modifiedDate")
    Date modifiedDate;
	@Column(name = "corrigendumId")
	Integer corrigendumId;
	@Column(name = "isAuction")
	Integer isAuction;
	
	public Integer getIsAuction() {
		return isAuction;
	}
	public void setIsAuction(Integer isAuction) {
		this.isAuction = isAuction;
	}
	public Integer getCorrigendumId() {
		return corrigendumId;
	}
	public void setCorrigendumId(Integer corrigendumId) {
		this.corrigendumId = corrigendumId;
	}
	public Integer getWorkflowId() {
		return workflowId;
	}
	public void setWorkflowId(Integer workflowId) {
		this.workflowId = workflowId;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public TblOfficer getTblOfficer() {
		return tblOfficer;
	}
	public void setTblOfficer(TblOfficer tblOfficer) {
		this.tblOfficer = tblOfficer;
	}
	public TblTender getTblTender() {
		return tblTender;
	}
	public void setTblTender(TblTender tblTender) {
		this.tblTender = tblTender;
	}
	public int getParentWorkflowId() {
		return parentWorkflowId;
	}
	public void setParentWorkflowId(int parentWorkflowId) {
		this.parentWorkflowId = parentWorkflowId;
	}
	public int getCstatus() {
		return cstatus;
	}
	public void setCstatus(int cstatus) {
		this.cstatus = cstatus;
	}
	public int getCreatedById() {
		return createdById;
	}
	public void setCreatedById(int createdById) {
		this.createdById = createdById;
	}
	public String getCreatedbyName() {
		return createdbyName;
	}
	public void setCreatedbyName(String createdbyName) {
		this.createdbyName = createdbyName;
	}
	public int getModifiedById() {
		return modifiedById;
	}
	public void setModifiedById(int modifiedById) {
		this.modifiedById = modifiedById;
	}
	public String getModifiedByName() {
		return modifiedByName;
	}
	public void setModifiedByName(String modifiedByName) {
		this.modifiedByName = modifiedByName;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Date getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
   
}
