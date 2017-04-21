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
@Table(name="tbl_itemselection")
public class TblItemSelection  implements java.io.Serializable {

        private   int bidderItemId;
        private   int createdBy;
        private   Date createdOn=new Date();
        private   int isSelected;
        private   int isBidded;
        private   Integer rowId;
        private   TblCompany tblCompany;
        private   TblTender tblTender;
        private   TblTenderEnvelope tblTenderEnvelope;
        private   TblTenderForm tblTenderForm;
        private   TblTenderTable tblTenderTable;
        private   int bidderId;

        @Column(name="bidderId",nullable=false)
        public int getBidderId() {
			return bidderId;
		}

		public void setBidderId(int bidderId) {
			this.bidderId = bidderId;
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
        public TblItemSelection(int bidderItemId){
            this.bidderItemId = bidderItemId;
        }
        @Column(name="createdBy",nullable=false)
        public int getCreatedBy() {
            return this.createdBy;
        }

        public void setCreatedBy(int createdBy) {
            this.createdBy = createdBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="createdOn")
        public Date getCreatedOn() {
            return this.createdOn;
        }

        public void setCreatedOn(Date createdOn) {
            this.createdOn = createdOn;
        }
        @Column(name="isSelected",nullable=false)
        public int getIsSelected() {
            return this.isSelected;
        }

        public void setIsSelected(int isSelected) {
            this.isSelected = isSelected;
        }
        
        @Column(name="isBidded",nullable=false)
        public int getIsBidded() {
            return this.isBidded;
        }

        public void setIsBidded(int isBidded) {
            this.isBidded = isBidded;
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
       
        public TblItemSelection(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("bidderItemId", this.getBidderItemId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("isApproved", this.getIsSelected())
.append("rowId", this.getRowId())
.append("isBidded", this.getIsBidded())
		.toString();

	}
}
