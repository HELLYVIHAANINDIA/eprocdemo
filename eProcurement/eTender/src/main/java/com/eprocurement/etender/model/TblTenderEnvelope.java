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
@Table(name="tbl_tenderenvelope")
public class TblTenderEnvelope  implements java.io.Serializable {

        private   int createdBy;
        private   Date createdOn;
        private   int cstatus;
        private   Integer envelopeId;
        private   String envelopeName;
        private   int isEvaluated;
        private   int isOpened;
        private   int minEvaluator;
        private   int minOpeningMember;
        private   int noOfFormsReq;
        private   Date openingDate;
        private   int publishedBy;
        private   Date publishedOn;
        private   int openingDatePublishedBy;
        private   Date openingDatePublishedOn;
        private   int openingDateStatus;
        private   String remark;
        private   int sortOrder;
        private   int minFormsReqForBidding;
        private   TblEnvelope tblEnvelope;
        private   TblTender tblTender;

        
        
        private Set<TblCommitteeEnvelope> tblCommitteeEnvelope = new HashSet<TblCommitteeEnvelope>();
        
        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderEnvelope")
        public Set<TblCommitteeEnvelope> getTblCommitteeEnvelope() {
			return tblCommitteeEnvelope;
		}
		public void setTblCommitteeEnvelope(
				Set<TblCommitteeEnvelope> tblCommitteeEnvelope) {
			this.tblCommitteeEnvelope = tblCommitteeEnvelope;
		}

        @Column(name="createdBy",nullable=false)
        public int getCreatedBy() {
            return this.createdBy;
        }

        public void setCreatedBy(int createdBy) {
            this.createdBy = createdBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="createdOn",nullable=true)
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
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="envelopeId",unique=true,nullable=false)
        public Integer getEnvelopeId() {
            return this.envelopeId;
        }

        public void setEnvelopeId(Integer envelopeId) {
            this.envelopeId = envelopeId;
        }
        public TblTenderEnvelope(int envelopeId){
            this.envelopeId = envelopeId;
        }
        @Column(name="envelopeName",nullable=false, length=50)
        public String getEnvelopeName() {
            return this.envelopeName;
        }

        public void setEnvelopeName(String envelopeName) {
            this.envelopeName = envelopeName;
        }
        @Column(name="isEvaluated",nullable=false)
        public int getIsEvaluated() {
            return this.isEvaluated;
        }

        public void setIsEvaluated(int isEvaluated) {
            this.isEvaluated = isEvaluated;
        }
        @Column(name="isOpened",nullable=false)
        public int getIsOpened() {
            return this.isOpened;
        }

        public void setIsOpened(int isOpened) {
            this.isOpened = isOpened;
        }
        @Column(name="minEvaluator",nullable=false)
        public int getMinEvaluator() {
            return this.minEvaluator;
        }

        public void setMinEvaluator(int minEvaluator) {
            this.minEvaluator = minEvaluator;
        }
        @Column(name="minOpeningMember",nullable=false)
        public int getMinOpeningMember() {
            return this.minOpeningMember;
        }

        public void setMinOpeningMember(int minOpeningMember) {
            this.minOpeningMember = minOpeningMember;
        }
        @Column(name="noOfFormsReq",nullable=false)
        public int getNoOfFormsReq() {
            return this.noOfFormsReq;
        }

        public void setNoOfFormsReq(int noOfFormsReq) {
            this.noOfFormsReq = noOfFormsReq;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="openingDate",nullable=true)
        public Date getOpeningDate() {
            return this.openingDate;
        }

        public void setOpeningDate(Date openingDate) {
            this.openingDate = openingDate;
        }
        @Column(name="publishedBy",nullable=true)
        public int getPublishedBy() {
            return this.publishedBy;
        }

        public void setPublishedBy(int publishedBy) {
            this.publishedBy = publishedBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="publishedOn",nullable=true)
        public Date getPublishedOn() {
            return this.publishedOn;
        }

        public void setPublishedOn(Date publishedOn) {
            this.publishedOn = publishedOn;
        }
        @Column(name="openingDatePublishedBy",nullable=true)
        public int getOpeningDatePublishedBy() {
            return this.openingDatePublishedBy;
        }

        public void setOpeningDatePublishedBy(int openingDatePublishedBy) {
            this.openingDatePublishedBy = openingDatePublishedBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="openingDatePublishedOn",nullable=true)
        public Date getOpeningDatePublishedOn() {
            return this.openingDatePublishedOn;
        }

        public void setOpeningDatePublishedOn(Date openingDatePublishedOn) {
            this.openingDatePublishedOn = openingDatePublishedOn;
        }
        @Column(name="openingDateStatus",nullable=false)
        public int getOpeningDateStatus() {
            return this.openingDateStatus;
        }

        public void setOpeningDateStatus(int openingDateStatus) {
            this.openingDateStatus = openingDateStatus;
        }
        @Column(name="remark",nullable=false, length=1000)
        public String getRemark() {
            return this.remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
        }
        @Column(name="sortOrder",nullable=false)
        public int getSortOrder() {
            return this.sortOrder;
        }

        public void setSortOrder(int sortOrder) {
            this.sortOrder = sortOrder;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="envid")
        public TblEnvelope getTblEnvelope() {
            return this.tblEnvelope;
        }

        public void setTblEnvelope(TblEnvelope tblEnvelope) {
            this.tblEnvelope = tblEnvelope;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderid")
        public TblTender getTblTender() {
            return this.tblTender;
        }

        @Column(name="minFormsReqForBidding",nullable=false, length=1000)
        public int getMinFormsReqForBidding() {
			return minFormsReqForBidding;
		}
		public void setMinFormsReqForBidding(int minFormsReqForBidding) {
			this.minFormsReqForBidding = minFormsReqForBidding;
		}
        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        public TblTenderEnvelope(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("cstatus", this.getCstatus())
.append("envelopeId", this.getEnvelopeId())
.append("envelopeName", this.getEnvelopeName())
.append("isEvaluated", this.getIsEvaluated())
.append("isOpened", this.getIsOpened())
.append("minEvaluator", this.getMinEvaluator())
.append("minOpeningMember", this.getMinOpeningMember())
.append("noOfFormsReq", this.getNoOfFormsReq())
.append("openingDate", this.getOpeningDate())
.append("publishedBy", this.getPublishedBy())
.append("publishedOn", this.getPublishedOn())
.append("openingDatePublishedBy", this.getOpeningDatePublishedBy())
.append("openingDatePublishedOn", this.getOpeningDatePublishedOn())
.append("openingDateStatus", this.getOpeningDateStatus())
.append("remark", this.getRemark())
.append("sortOrder", this.getSortOrder())


		.toString();

	}
}
