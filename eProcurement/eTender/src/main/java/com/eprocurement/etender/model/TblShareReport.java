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
@Table(name="tbl_sharereport")
public class TblShareReport  implements java.io.Serializable {

	private   int createdBy;
	private   Date createdOn;
	private   int isActive;
	private   int shareBidderStatus;
	private   int shareClarificationReport;
	private   int shareEvaluationReport;
	private   int shareReport;
	private   int shareReportId;
	private   int showAbstractReport;
	private   int showL1Report;
	private   int showResultBeforeLogin;
	private   TblTender tblTender;

	private Set<TblShareReportDetail> tblShareReportDetail = new HashSet<TblShareReportDetail>();

	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblShareReport")
	public Set<TblShareReportDetail> getTblShareReportDetail()
	{
		return tblShareReportDetail;
	}
	public void setTblShareReportDetail(Set<TblShareReportDetail> tblShareReportDetail)
	{
		this.tblShareReportDetail = tblShareReportDetail;
	}


	@Column(name="createdBy",nullable=false)
	public int getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="createdOn",nullable=false,updatable=false,insertable=false)
	public Date getCreatedOn() {
		return this.createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
	@Column(name="isActive",nullable=false)
	public int getIsActive() {
		return this.isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	@Column(name="shareBidderStatus",nullable=false)
	public int getShareBidderStatus() {
		return this.shareBidderStatus;
	}

	public void setShareBidderStatus(int shareBidderStatus) {
		this.shareBidderStatus = shareBidderStatus;
	}
	@Column(name="shareClarificationReport",nullable=false)
	public int getShareClarificationReport() {
		return this.shareClarificationReport;
	}

	public void setShareClarificationReport(int shareClarificationReport) {
		this.shareClarificationReport = shareClarificationReport;
	}
	@Column(name="shareEvaluationReport",nullable=false)
	public int getShareEvaluationReport() {
		return this.shareEvaluationReport;
	}

	public void setShareEvaluationReport(int shareEvaluationReport) {
		this.shareEvaluationReport = shareEvaluationReport;
	}
	@Column(name="shareReport",nullable=false)
	public int getShareReport() {
		return this.shareReport;
	}

	public void setShareReport(int shareReport) {
		this.shareReport = shareReport;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="shareReportId",unique=true,nullable=false)
	public int getShareReportId() {
		return this.shareReportId;
	}

	public void setShareReportId(int shareReportId) {
		this.shareReportId = shareReportId;
	}
	public TblShareReport(int shareReportId){
		this.shareReportId = shareReportId;
	}
	@Column(name="showAbstractReport",nullable=false)
	public int getShowAbstractReport() {
		return this.showAbstractReport;
	}

	public void setShowAbstractReport(int showAbstractReport) {
		this.showAbstractReport = showAbstractReport;
	}
	@Column(name="showL1Report",nullable=false)
	public int getShowL1Report() {
		return this.showL1Report;
	}

	public void setShowL1Report(int showL1Report) {
		this.showL1Report = showL1Report;
	}
	@Column(name="showResultBeforeLogin",nullable=false)
	public int getShowResultBeforeLogin() {
		return this.showResultBeforeLogin;
	}

	public void setShowResultBeforeLogin(int showResultBeforeLogin) {
		this.showResultBeforeLogin = showResultBeforeLogin;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="tenderid")
	public TblTender getTblTender() {
		return this.tblTender;
	}

	public void setTblTender(TblTender tblTender) {
		this.tblTender = tblTender;
	}
	public TblShareReport(){
	}
	@Override
	public String toString() {
		return new ToStringCreator(this)
		.append("createdBy", this.getCreatedBy())
		.append("createdOn", this.getCreatedOn())
		.append("isActive", this.getIsActive())
		.append("shareBidderStatus", this.getShareBidderStatus())
		.append("shareClarificationReport", this.getShareClarificationReport())
		.append("shareEvaluationReport", this.getShareEvaluationReport())
		.append("shareReport", this.getShareReport())
		.append("shareReportId", this.getShareReportId())
		.append("showAbstractReport", this.getShowAbstractReport())
		.append("showL1Report", this.getShowL1Report())
		.append("showResultBeforeLogin", this.getShowResultBeforeLogin())
		.toString();
	}
}
