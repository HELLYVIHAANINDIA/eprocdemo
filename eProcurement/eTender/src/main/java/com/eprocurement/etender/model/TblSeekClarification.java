/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
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
@Table(name="tbl_seekclarification")
public class TblSeekClarification  implements java.io.Serializable {

        private   int clarificationId;
        private   int createdBy;
        private   Date createdOn;
        private   int isActive;
        private   Date responseEndDate;
        private   TblBidder tblBidder;
        private   TblTender tblTender;
        private   TblTenderEnvelope tblTenderEnvelope;
        private   TblOfficer tblOfficer;  


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="clarificationId",unique=true,nullable=false)
        public int getClarificationId() {
            return this.clarificationId;
        }

        public void setClarificationId(int clarificationId) {
            this.clarificationId = clarificationId;
        }
        public TblSeekClarification(int clarificationId){
            this.clarificationId = clarificationId;
        }
        @Column(name="createdBy",nullable=false)
        public int getCreatedBy() {
            return this.createdBy;
        }

        public void setCreatedBy(int createdBy) {
            this.createdBy = createdBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="createdOn",nullable=false)
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
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="responseEndDate",nullable=false)
        public Date getResponseEndDate() {
            return this.responseEndDate;
        }

        public void setResponseEndDate(Date responseEndDate) {
            this.responseEndDate = responseEndDate;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="bidderId")
        public TblBidder getTblBidder() {
            return this.tblBidder;
        }

        public void setTblBidder(TblBidder tblBidder) {
            this.tblBidder = tblBidder;
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
        @JoinColumn(name="officerId")
        public TblOfficer getTblOfficer() {
            return this.tblOfficer;
        }

        public void setTblOfficer(TblOfficer tblOfficer) {
            this.tblOfficer = tblOfficer;
        }
        
        public TblSeekClarification(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("clarificationId", this.getClarificationId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("isActive", this.getIsActive())
.append("responseEndDate", this.getResponseEndDate())

		.toString();

	}
}
