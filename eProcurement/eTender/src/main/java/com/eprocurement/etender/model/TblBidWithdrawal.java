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
@Table(name="tbl_bidwithdrawal")
public class TblBidWithdrawal  implements java.io.Serializable {

        private   int bidWithdrawalId;
        private   int createdBy;
        private   Date createdOn;
        private   Date finalSubmissionDate;
        private   String finalSubmissionIPAddress;
        private   String ipAddress;
        private   String remark;
        private   TblCompany tblCompany;
        private   TblTender tblTender;
        private   int bidderId;


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="bidWithdrawalId",unique=true,nullable=false)
        public int getBidWithdrawalId() {
            return this.bidWithdrawalId;
        }

        public void setBidWithdrawalId(int bidWithdrawalId) {
            this.bidWithdrawalId = bidWithdrawalId;
        }
        public TblBidWithdrawal(int bidWithdrawalId){
            this.bidWithdrawalId = bidWithdrawalId;
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
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="finalSubmissionDate")
        public Date getFinalSubmissionDate() {
            return this.finalSubmissionDate;
        }

        public void setFinalSubmissionDate(Date finalSubmissionDate) {
            this.finalSubmissionDate = finalSubmissionDate;
        }
        @Column(name="finalSubmissionIPAddress",nullable=false, length= 20)
        public String getFinalSubmissionIPAddress() {
            return this.finalSubmissionIPAddress;
        }

        public void setFinalSubmissionIPAddress(String finalSubmissionIPAddress) {
            this.finalSubmissionIPAddress = finalSubmissionIPAddress;
        }
        @Column(name="ipAddress",nullable=false, length= 20)
        public String getIpAddress() {
            return this.ipAddress;
        }

        public void setIpAddress(String ipAddress) {
            this.ipAddress = ipAddress;
        }
        @Column(name="remark",nullable=false, length=1000)
        public String getRemark() {
            return this.remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
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
        @Column(name="bidderId",nullable=false)
        public int getBidderId() {
			return bidderId;
		}

		public void setBidderId(int bidderId) {
			this.bidderId = bidderId;
		}

		public TblBidWithdrawal(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("bidWithdrawalId", this.getBidWithdrawalId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("finalSubmissionDate", this.getFinalSubmissionDate())
.append("finalSubmissionIPAddress", this.getFinalSubmissionIPAddress())
.append("ipAddress", this.getIpAddress())
.append("remark", this.getRemark())




		.toString();

	}
}

