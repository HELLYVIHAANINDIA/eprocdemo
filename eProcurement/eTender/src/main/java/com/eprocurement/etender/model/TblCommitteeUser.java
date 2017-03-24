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
@Table(name="tbl_committeeuser")
public class TblCommitteeUser  implements java.io.Serializable {

        /**
	 * 
	 */
	private static final long serialVersionUID = 675103319316424519L;
		private   int approvedBy;
        private   Date approvedOn;
        private   int childId;
        private   int committeeUserId;
        private   int createdBy;
        private   Date createdOn;
        private   int encryptionLevel;
        private   int isApproved;
        private   int isDecryptor;
        private   String remarks;
        private   TblCommittee tblCommittee;
        private   TblOfficer tblOfficer;
        
		private   int userRoleId;

        @Column(name="approvedBy",nullable=true)
        public int getApprovedBy() {
            return this.approvedBy;
        }

        public void setApprovedBy(int approvedBy) {
            this.approvedBy = approvedBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="approvedOn",nullable=true)
        public Date getApprovedOn() {
            return this.approvedOn;
        }

        public void setApprovedOn(Date approvedOn) {
            this.approvedOn = approvedOn;
        }
        @Column(name="childId",nullable=false)
        public int getChildId() {
            return this.childId;
        }

        public void setChildId(int childId) {
            this.childId = childId;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="committeeUserId",unique=true,nullable=false)
        public int getCommitteeUserId() {
            return this.committeeUserId;
        }

        public void setCommitteeUserId(int committeeUserId) {
            this.committeeUserId = committeeUserId;
        }
        public TblCommitteeUser(int committeeUserId){
            this.committeeUserId = committeeUserId;
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
        @Column(name="encryptionLevel",nullable=false)
        public int getEncryptionLevel() {
            return this.encryptionLevel;
        }

        public void setEncryptionLevel(int encryptionLevel) {
            this.encryptionLevel = encryptionLevel;
        }
        @Column(name="isApproved",nullable=false)
        public int getIsApproved() {
            return this.isApproved;
        }

        public void setIsApproved(int isApproved) {
            this.isApproved = isApproved;
        }
        @Column(name="isDecryptor",nullable=false)
        public int getIsDecryptor() {
            return this.isDecryptor;
        }

        public void setIsDecryptor(int isDecryptor) {
            this.isDecryptor = isDecryptor;
        }
        @Column(name="remarks", length=1000)
        public String getRemarks() {
            return this.remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="committeeId")
        public TblCommittee getTblCommittee() {
            return this.tblCommittee;
        }

        public void setTblCommittee(TblCommittee tblCommittee) {
            this.tblCommittee = tblCommittee;
        }
        
        @ManyToOne(fetch=FetchType.EAGER)
        @JoinColumn(name="officerid")
        public TblOfficer getTblOfficer() {
            return this.tblOfficer;
        }

        public void setTblOfficer(TblOfficer tblOfficer) {
            this.tblOfficer = tblOfficer;
        }
        @Column(name="userRoleId",nullable=true)
        public int getUserRoleId() {
            return this.userRoleId;
        }

        public void setUserRoleId(int userRoleId) {
            this.userRoleId = userRoleId;
        }
        public TblCommitteeUser(){
        }
        
        
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("approvedBy", this.getApprovedBy())
.append("approvedOn", this.getApprovedOn())
.append("childId", this.getChildId())
.append("committeeUserId", this.getCommitteeUserId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("encryptionLevel", this.getEncryptionLevel())
.append("isApproved", this.getIsApproved())
.append("isDecryptor", this.getIsDecryptor())
.append("remarks", this.getRemarks())
.append("userRoleId", this.getUserRoleId())



		.toString();

	}
}
