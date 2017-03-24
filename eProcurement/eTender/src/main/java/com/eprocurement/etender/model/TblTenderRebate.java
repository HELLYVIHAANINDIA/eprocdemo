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
@Table(name="tbl_tenderrebate")
public class TblTenderRebate  implements java.io.Serializable {

        private   int createdBy;
        private   Date createdOn;
        private   String rebateEncrypt;
        private   String rebateValue;
        private   TblCompany tblCompany;
        private   TblTender tblTender;
        private   int tenderRebateId;

        private Set<TblTenderRebateDetail> tblTenderRebateDetail = new HashSet<TblTenderRebateDetail>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderRebate")
        public Set<TblTenderRebateDetail> getTblTenderRebateDetail()
        {
            return tblTenderRebateDetail;
        }
        public void setTblTenderRebateDetail(Set<TblTenderRebateDetail> tblTenderRebateDetail)
        {
            this.tblTenderRebateDetail = tblTenderRebateDetail;
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
        @Column(name="rebateEncrypt",nullable=false, length=0)
        public String getRebateEncrypt() {
            return this.rebateEncrypt;
        }

        public void setRebateEncrypt(String rebateEncrypt) {
            this.rebateEncrypt = rebateEncrypt;
        }
        @Column(name="rebateValue",nullable=false, length=0)
        public String getRebateValue() {
            return this.rebateValue;
        }

        public void setRebateValue(String rebateValue) {
            this.rebateValue = rebateValue;
        }
        @ManyToOne(fetch=FetchType.EAGER)
        @JoinColumn(name="companyid")
        public TblCompany getTblCompany() {
            return this.tblCompany;
        }

        public void setTblCompany(TblCompany tblCompany) {
            this.tblCompany = tblCompany;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderId")
        public TblTender getTblTender() {
            return this.tblTender;
        }

        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="tenderRebateId",unique=true,nullable=false)
        public int getTenderRebateId() {
            return this.tenderRebateId;
        }

        public void setTenderRebateId(int tenderRebateId) {
            this.tenderRebateId = tenderRebateId;
        }
        public TblTenderRebate(int tenderRebateId){
            this.tenderRebateId = tenderRebateId;
        }
        public TblTenderRebate(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("rebateValue", this.getRebateValue())


.append("tenderRebateId", this.getTenderRebateId())
		.toString();

	}
}
