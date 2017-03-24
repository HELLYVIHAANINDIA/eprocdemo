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
@Table(name="tbl_consortium")
public class TblConsortium  implements java.io.Serializable {

        private   int consortiumId;
        private   int createdBy;
        private   Date createdOn;
        private   Date deletedOn;
        private   int isActive;
        private   TblTender tblTender;
        private   Date approvedOn;

        private Set<TblConsortiumDetail> tblConsortiumDetail = new HashSet<TblConsortiumDetail>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblConsortium")
        public Set<TblConsortiumDetail> getTblConsortiumDetail()
        {
            return tblConsortiumDetail;
        }
        public void setTblConsortiumDetail(Set<TblConsortiumDetail> tblConsortiumDetail)
        {
            this.tblConsortiumDetail = tblConsortiumDetail;
        }
        
         @Temporal(TemporalType.TIMESTAMP)
        @Column(name="approvedOn",nullable=true)
        public Date getApprovedOn() {
            return this.approvedOn;
        }

        public void setApprovedOn(Date approvedOn) {
            this.approvedOn = approvedOn;
        }

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="consortiumId",unique=true,nullable=false)
        public int getConsortiumId() {
            return this.consortiumId;
        }

        public void setConsortiumId(int consortiumId) {
            this.consortiumId = consortiumId;
        }
        public TblConsortium(int consortiumId){
            this.consortiumId = consortiumId;
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
        @Column(name="deletedOn",nullable=true)
        public Date getDeletedOn() {
            return this.deletedOn;
        }

        public void setDeletedOn(Date deletedOn) {
            this.deletedOn = deletedOn;
        }
        @Column(name="isActive",nullable=false)
        public int getIsActive() {
            return this.isActive;
        }

        public void setIsActive(int isActive) {
            this.isActive = isActive;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderid")
        public TblTender getTblTender() {
            return this.tblTender;
        }

        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        public TblConsortium(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("consortiumId", this.getConsortiumId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("deletedOn", this.getDeletedOn())
.append("isActive", this.getIsActive())

		.toString();

	}
}
