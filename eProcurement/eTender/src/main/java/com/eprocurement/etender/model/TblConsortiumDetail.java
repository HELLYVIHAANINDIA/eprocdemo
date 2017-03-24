package com.eprocurement.etender.model;

import java.math.BigDecimal;
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
@Table(name="tbl_consortiumdetail")
public class TblConsortiumDetail  implements java.io.Serializable {

        private   int consortiumDetailId;
        private   int createdBy;
        private   Date createdOn;
        private   int cstatus;
        private   BigDecimal partnerStake;
        private   int partnerType;
        private   Date rejectedOn;
        private   String remarks;
        private   TblCompany tblCompany;
        private   TblConsortium tblConsortium;
        private   TblUserLogin tblUserLogin;


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="consortiumDetailId",unique=true,nullable=false)
        public int getConsortiumDetailId() {
            return this.consortiumDetailId;
        }

        public void setConsortiumDetailId(int consortiumDetailId) {
            this.consortiumDetailId = consortiumDetailId;
        }
        public TblConsortiumDetail(int consortiumDetailId){
            this.consortiumDetailId = consortiumDetailId;
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
        @Column(name="cstatus",nullable=false)
        public int getCstatus() {
            return this.cstatus;
        }

        public void setCstatus(int cstatus) {
            this.cstatus = cstatus;
        }
        
        @Column(name="partnerStake",nullable=false)
        public BigDecimal getPartnerStake() {
            return this.partnerStake;
        }

        public void setPartnerStake(BigDecimal partnerStake) {
            this.partnerStake = partnerStake;
        }
        
        @Column(name="partnerType",nullable=false)
        public int getPartnerType() {
            return this.partnerType;
        }

        public void setPartnerType(int partnerType) {
            this.partnerType = partnerType;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="rejectedOn",nullable=true)
        public Date getRejectedOn() {
            return this.rejectedOn;
        }

        public void setRejectedOn(Date rejectedOn) {
            this.rejectedOn = rejectedOn;
        }
        @Column(name="remarks",nullable=false, length=1000)
        public String getRemarks() {
            return this.remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
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
        @JoinColumn(name="consortiumid")
        public TblConsortium getTblConsortium() {
            return this.tblConsortium;
        }

        public void setTblConsortium(TblConsortium tblConsortium) {
            this.tblConsortium = tblConsortium;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="bidderid")
        public TblUserLogin getTblUserLogin() {
            return this.tblUserLogin;
        }

        public void setTblUserLogin(TblUserLogin tblUserLogin) {
            this.tblUserLogin = tblUserLogin;
        }
        public TblConsortiumDetail(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("consortiumDetailId", this.getConsortiumDetailId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("cstatus", this.getCstatus())
.append("partnerType", this.getPartnerType())
.append("partnerStake", this.getPartnerStake())
.append("rejectedOn", this.getRejectedOn())
.append("remarks", this.getRemarks())




		.toString();

	}
}
