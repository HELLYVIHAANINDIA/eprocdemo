package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name="tbl_sharereportdetail")
public class TblShareReportDetail  implements java.io.Serializable {

	private   int shareComparativeReport;
	private   int shareDocument;
	private   int shareIndividualReport;
	private   int shareReportDetailId;
	private   TblShareReport tblShareReport;
	private   TblTenderForm tblTenderForm;

	@Column(name="shareComparativeReport",nullable=false)
	public int getShareComparativeReport() {
		return this.shareComparativeReport;
	}

	public void setShareComparativeReport(int shareComparativeReport) {
		this.shareComparativeReport = shareComparativeReport;
	}
	@Column(name="shareDocument",nullable=false)
	public int getShareDocument() {
		return this.shareDocument;
	}

	public void setShareDocument(int shareDocument) {
		this.shareDocument = shareDocument;
	}
	@Column(name="shareIndividualReport",nullable=false)
	public int getShareIndividualReport() {
		return this.shareIndividualReport;
	}

	public void setShareIndividualReport(int shareIndividualReport) {
		this.shareIndividualReport = shareIndividualReport;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="shareReportDetailId",unique=true,nullable=false)
	public int getShareReportDetailId() {
		return this.shareReportDetailId;
	}

	public void setShareReportDetailId(int shareReportDetailId) {
		this.shareReportDetailId = shareReportDetailId;
	}
	public TblShareReportDetail(int shareReportDetailId){
		this.shareReportDetailId = shareReportDetailId;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="sharereportid")
	public TblShareReport getTblShareReport() {
		return this.tblShareReport;
	}

	public void setTblShareReport(TblShareReport tblShareReport) {
		this.tblShareReport = tblShareReport;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="formid")
	public TblTenderForm getTblTenderForm() {
		return this.tblTenderForm;
	}

	public void setTblTenderForm(TblTenderForm tblTenderForm) {
		this.tblTenderForm = tblTenderForm;
	}
	public TblShareReportDetail(){
	}
	@Override
	public String toString() {
		return new ToStringCreator(this)
		.append("shareComparativeReport", this.getShareComparativeReport())
		.append("shareDocument", this.getShareDocument())
		.append("shareIndividualReport", this.getShareIndividualReport())
		.append("shareReportDetailId", this.getShareReportDetailId())
		.toString();
	}
}
