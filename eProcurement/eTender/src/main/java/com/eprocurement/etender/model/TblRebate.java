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
//Not in used

@Entity
@Table(name="tbl_rebate")
public class TblRebate  implements java.io.Serializable {

        private   int createdBy;
        private   Date createdOn;
        private   String ipAddress;
        private   int isRebateForm;
        private   int rebateId;
        private   String reportName;
        private   TblTender tblTender;

        private Set<TblRebateForm> tblRebateForm = new HashSet<TblRebateForm>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblRebate")
        public Set<TblRebateForm> getTblRebateForm()
        {
            return tblRebateForm;
        }
        public void setTblRebateForm(Set<TblRebateForm> tblRebateForm)
        {
            this.tblRebateForm = tblRebateForm;
        }
        /*private Set<TblTenderRebate> tblTenderRebate = new HashSet<TblTenderRebate>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblRebate")
        public Set<TblTenderRebate> getTblTenderRebate()
        {
            return tblTenderRebate;
        }
        public void setTblTenderRebate(Set<TblTenderRebate> tblTenderRebate)
        {
            this.tblTenderRebate = tblTenderRebate;
        }
*/
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
        @Column(name="ipAddress",nullable=false, length= 20)
        public String getIpAddress() {
            return this.ipAddress;
        }

        public void setIpAddress(String ipAddress) {
            this.ipAddress = ipAddress;
        }
        @Column(name="isRebateForm",nullable=false)
        public int getIsRebateForm() {
            return this.isRebateForm;
        }

        public void setIsRebateForm(int isRebateForm) {
            this.isRebateForm = isRebateForm;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="rebateId",unique=true,nullable=false)
        public int getRebateId() {
            return this.rebateId;
        }

        public void setRebateId(int rebateId) {
            this.rebateId = rebateId;
        }
        public TblRebate(int rebateId){
            this.rebateId = rebateId;
        }
        @Column(name="reportName",nullable=false, length=15)
        public String getReportName() {
            return this.reportName;
        }

        public void setReportName(String reportName) {
            this.reportName = reportName;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderid")
        public TblTender getTblTender() {
            return this.tblTender;
        }

        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        public TblRebate(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("ipAddress", this.getIpAddress())
.append("isRebateForm", this.getIsRebateForm())
.append("rebateId", this.getRebateId())
.append("reportName", this.getReportName())

		.toString();

	}
}
