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

@Entity
@Table(name="tbl_bidderitems",schema="apptenderresult")
public class TblBidderItems  implements java.io.Serializable {

	private   int bidderItemId;
    private   int childId;
    private   int createdBy;
    private   int isActive;
    private   int isApproved;
    private   int isCPRemarks;
    private   String remarks;
    private   Integer rowId;
    private   TblCompany tblCompany;
    private   TblTender tblTender;
    private   TblTenderEnvelope tblTenderEnvelope;
    private   TblTenderForm tblTenderForm;
    private   TblTenderTable tblTenderTable;
    private   TblBidder tblBidder;
    private   int userRoleId;

    @Column(name="userRoleId",nullable=true)
    public int getUserRoleId() {
        return this.userRoleId;
    }

    public void setUserRoleId(int userRoleId) {
        this.userRoleId = userRoleId;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="bidderItemId",unique=true,nullable=false)
    public int getBidderItemId() {
        return this.bidderItemId;
    }

    public void setBidderItemId(int bidderItemId) {
        this.bidderItemId = bidderItemId;
    }
    public TblBidderItems(int bidderItemId){
        this.bidderItemId = bidderItemId;
    }
    @Column(name="childId",nullable=false)
    public int getChildId() {
        return this.childId;
    }

    public void setChildId(int childId) {
        this.childId = childId;
    }
    @Column(name="createdBy",nullable=false)
    public int getCreatedBy() {
        return this.createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
    @Column(name="isActive",nullable=false)
    public int getIsActive() {
        return this.isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
    @Column(name="isApproved",nullable=false)
    public int getIsApproved() {
        return this.isApproved;
    }

    public void setIsApproved(int isApproved) {
        this.isApproved = isApproved;
    }
    @Column(name="isCPRemarks",nullable=false)
    public int getIsCPRemarks() {
        return this.isCPRemarks;
    }

    public void setIsCPRemarks(int isCPRemarks) {
        this.isCPRemarks = isCPRemarks;
    }
    @Column(name="remarks",nullable=true, length=500)
    public String getRemarks() {
        return this.remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
    @Column(name="rowId",nullable=false)
    public Integer getRowId() {
        return this.rowId;
    }

    public void setRowId(Integer rowId) {
        this.rowId = rowId;
    }
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="companyid")
    public TblCompany getTblCompany() {
        return this.tblCompany;
    }

    public void setTblCompany(TblCompany tblCompany) {
        this.tblCompany = tblCompany;
    }
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderid")
    public TblTender getTblTender() {
        return this.tblTender;
    }

    public void setTblTender(TblTender tblTender) {
        this.tblTender = tblTender;
    }
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="envelopeid")
    public TblTenderEnvelope getTblTenderEnvelope() {
        return this.tblTenderEnvelope;
    }

    public void setTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope) {
        this.tblTenderEnvelope = tblTenderEnvelope;
    }
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="formid")
    public TblTenderForm getTblTenderForm() {
        return this.tblTenderForm;
    }

    public void setTblTenderForm(TblTenderForm tblTenderForm) {
        this.tblTenderForm = tblTenderForm;
    }
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tableid")
    public TblTenderTable getTblTenderTable() {
        return this.tblTenderTable;
    }

    public void setTblTenderTable(TblTenderTable tblTenderTable) {
        this.tblTenderTable = tblTenderTable;
    }
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="bidderId")
    public TblBidder getTblBidder() {
        return this.tblBidder;
    }

    public void setTblBidder(TblBidder tblBidder) {
        this.tblBidder = tblBidder;
    }
    public TblBidderItems(){
    }
    @Override
	public String toString() {
		return new ToStringCreator(this)
	.append("bidderItemId", this.getBidderItemId())
	.append("childId", this.getChildId())
	.append("createdBy", this.getCreatedBy())
	.append("isActive", this.getIsActive())
	.append("isApproved", this.getIsApproved())
	.append("isCPRemarks", this.getIsCPRemarks())
	.append("remarks", this.getRemarks())
	.append("rowId", this.getRowId())
	.append("userRoleId", this.getUserRoleId())
		.toString();
	
    }
}