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
@Table(name="tbl_committee")
public class TblCommittee  implements java.io.Serializable {

        /**
	 * 
	 */
	private static final long serialVersionUID = -825329703992315055L;
		private   int committeeId;
        private   String committeeName;
        private   int committeeType;
        private   int createdBy;
        private   Date createdOn;
        private   int isActive;
        private   int isApproved;
        private   int isStandard;
        private   int publishedBy;
        private   Date publishedOn;
        private   String remarks;
        private   TblTender tblTender;

        private Set<TblCommitteeUser> tblCommitteeUser = new HashSet<TblCommitteeUser>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblCommittee")
        public Set<TblCommitteeUser> getTblCommitteeUser()
        {
            return tblCommitteeUser;
        }
        public void setTblCommitteeUser(Set<TblCommitteeUser> tblCommitteeUser)
        {
            this.tblCommitteeUser = tblCommitteeUser;
        }
        
        private Set<TblCommitteeEnvelope> tblCommitteeEnvelope = new HashSet<TblCommitteeEnvelope>();
        
        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblCommittee")
        public Set<TblCommitteeEnvelope> getTblCommitteeEnvelope() {
			return tblCommitteeEnvelope;
		}
		public void setTblCommitteeEnvelope(
				Set<TblCommitteeEnvelope> tblCommitteeEnvelope) {
			this.tblCommitteeEnvelope = tblCommitteeEnvelope;
		}
		
		@Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="committeeId",unique=true,nullable=false)
        public int getCommitteeId() {
            return this.committeeId;
        }

        public void setCommitteeId(int committeeId) {
            this.committeeId = committeeId;
        }
        public TblCommittee(int committeeId){
            this.committeeId = committeeId;
        }
        @Column(name="committeeName",nullable=false, length=50)
        public String getCommitteeName() {
            return this.committeeName;
        }

        public void setCommitteeName(String committeeName) {
            this.committeeName = committeeName;
        }
        @Column(name="committeeType",nullable=false)
        public int getCommitteeType() {
            return this.committeeType;
        }

        public void setCommitteeType(int committeeType) {
            this.committeeType = committeeType;
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
        @Column(name="isApproved",nullable=false)
        public int getIsApproved() {
            return this.isApproved;
        }

        public void setIsApproved(int isApproved) {
            this.isApproved = isApproved;
        }
        @Column(name="isStandard",nullable=false)
        public int getIsStandard() {
            return this.isStandard;
        }

        public void setIsStandard(int isStandard) {
            this.isStandard = isStandard;
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
        @Column(name="remarks", length=1000)
        public String getRemarks() {
            return this.remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }
       
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderId")
        public TblTender getTblTender() {
            return this.tblTender;
        }

        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        public TblCommittee(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("committeeId", this.getCommitteeId())
.append("committeeName", this.getCommitteeName())
.append("committeeType", this.getCommitteeType())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("isActive", this.getIsActive())
.append("isApproved", this.getIsApproved())
.append("isStandard", this.getIsStandard())
.append("publishedBy", this.getPublishedBy())
.append("publishedOn", this.getPublishedOn())
.append("remarks", this.getRemarks())


		.toString();

	}
}
