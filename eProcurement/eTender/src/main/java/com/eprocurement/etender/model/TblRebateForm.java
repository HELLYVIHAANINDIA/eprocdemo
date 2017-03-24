package com.eprocurement.etender.model;

import java.math.BigDecimal;
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
@Table(name="tbl_rebateform")
public class TblRebateForm  implements java.io.Serializable {

        private   int createdBy;
        private   Date createdOn;
        private   String ipAddress;
        private   int rebateFormId;
        private   TblRebate tblRebate;
        private   TblTenderCell tblTenderCell;
        private   TblTenderForm tblTenderForm;


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
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="rebateFormId",unique=true,nullable=false)
        public int getRebateFormId() {
            return this.rebateFormId;
        }

        public void setRebateFormId(int rebateFormId) {
            this.rebateFormId = rebateFormId;
        }
        public TblRebateForm(int rebateFormId){
            this.rebateFormId = rebateFormId;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="rebateid")
        public TblRebate getTblRebate() {
            return this.tblRebate;
        }

        public void setTblRebate(TblRebate tblRebate) {
            this.tblRebate = tblRebate;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="cellid")
        public TblTenderCell getTblTenderCell() {
            return this.tblTenderCell;
        }

        public void setTblTenderCell(TblTenderCell tblTenderCell) {
            this.tblTenderCell = tblTenderCell;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="formid")
        public TblTenderForm getTblTenderForm() {
            return this.tblTenderForm;
        }

        public void setTblTenderForm(TblTenderForm tblTenderForm) {
            this.tblTenderForm = tblTenderForm;
        }
        public TblRebateForm(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("ipAddress", this.getIpAddress())
.append("rebateFormId", this.getRebateFormId())



		.toString();

	}
}
