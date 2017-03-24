package com.eprocurement.etender.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.core.style.ToStringCreator;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.OneToMany;

@Entity
@Table(name="tbl_tenderaudittrail")
public class TblTenderAuditTrail  implements java.io.Serializable {

	private   Date createdOn;
	private   int linkId;
	private   long objectId;
	private   String pageUrl;
	private   String remark;
	private   String loginUserId;
	private   long tenderAuditTrailId;
	private   int tenderId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="createdOn",nullable=false,updatable=false,insertable=false)
	public Date getCreatedOn() {
		return this.createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
	@Column(name="linkId",nullable=false)
	public int getLinkId() {
		return this.linkId;
	}

	public void setLinkId(int linkId) {
		this.linkId = linkId;
	}
	@Column(name="objectId",nullable=false)
	public long getObjectId() {
		return this.objectId;
	}

	public void setObjectId(long objectId) {
		this.objectId = objectId;
	}
	@Column(name="pageUrl",nullable=false, length= 1000)
	public String getPageUrl() {
		return this.pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	@Column(name="remark",nullable=false, length= 100)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="tenderAuditTrailId",unique=true,nullable=false)
	public long getTenderAuditTrailId() {
		return this.tenderAuditTrailId;
	}

	public void setTenderAuditTrailId(long tenderAuditTrailId) {
		this.tenderAuditTrailId = tenderAuditTrailId;
	}
	public TblTenderAuditTrail(long tenderAuditTrailId){
		this.tenderAuditTrailId = tenderAuditTrailId;
	}
	@Column(name="tenderId",nullable=false)
	public int getTenderId() {
		return this.tenderId;
	}

	public void setTenderId(int tenderId) {
		this.tenderId = tenderId;
	}
	
	@Column(name="loginUserId",nullable=false)
	public String getLoginUserId() {
		return loginUserId;
	}

	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}

	public TblTenderAuditTrail(){
	}
	
}
