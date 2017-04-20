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
@Table(name="tbl_tenderform")
public class TblTenderForm  implements java.io.Serializable {
		private   Integer cancelledBy;
		private   Integer isCanceled;
	    private   Date cancelledOn;
        private   int createdBy;
        private   Date createdOn;
        private   int cstatus;
        private   String formFooter;
        private   String formHeader;
        private   int formId;
        private   String formName;
        private   int incrementItems;
        private   int isDocumentReq;
        private   int isEncryptedDocument;
        private   int isEncryptionReq;
        private   int isEvaluationReq;
        private   int isMandatory;
        private   int isMultipleFilling;
        private   int isPriceBid;
        private   int isSecondary;
        private   Integer loadNoOfItems;
        private   int noOfTables;
        private   Integer publishedBy;
        private   Date publishedOn;
        private   int sortOrder;
        private   TblTender tblTender;
        private   TblTenderEnvelope tblTenderEnvelope;
        private   int masterFormId;
        private   int isItemWiseDocAllowed;
        private   int minTablesReqForBidding;
        private   int parentFormId;
        private   double formWeight=0.0;
        private   double corrigendumFormWeight=0.0;

        @Column(name="corrigendumFormWeight")
        public double getCorrigendumFormWeight() {
			return corrigendumFormWeight;
		}

		public void setCorrigendumFormWeight(double corrigendumFormWeight) {
			this.corrigendumFormWeight = corrigendumFormWeight;
		}

		@Column(name="formWeight")
        public double getFormWeight() {
			return formWeight;
		}

		public void setFormWeight(double formWeight) {
			this.formWeight = formWeight;
		}

		@Column(name="masterFormId",nullable=false)
        public int getMasterFormId() {
            return this.masterFormId;
        }

        public void setMasterFormId(int masterFormId) {
            this.masterFormId = masterFormId;
        }
        
        @Column(name="cancelledBy",nullable=true)
        public Integer getCancelledBy() {
            return this.cancelledBy;
        }

        public void setCancelledBy(Integer cancelledBy) {
            this.cancelledBy = cancelledBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="cancelledOn",nullable=true)
        public Date getCancelledOn() {
            return this.cancelledOn;
        }

        public void setCancelledOn(Date cancelledOn) {
            this.cancelledOn = cancelledOn;
        }
        
        private Set<TblTenderBid> tblTenderBid = new HashSet<TblTenderBid>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderform")
        public Set<TblTenderBid> getTblTenderBid()
        {
            return tblTenderBid;
        }
        public void setTblTenderBid(Set<TblTenderBid> tblTenderBid)
        {
            this.tblTenderBid = tblTenderBid;
        }
        
        
        private Set<TblTenderCell> tblTenderCell = new HashSet<TblTenderCell>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderForm")
        public Set<TblTenderCell> getTblTenderCell()
        {
            return tblTenderCell;
        }
        public void setTblTenderCell(Set<TblTenderCell> tblTenderCell)
        {
            this.tblTenderCell = tblTenderCell;
        }

        private Set<TblTenderColumn> tblTenderColumn = new HashSet<TblTenderColumn>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderForm")
        public Set<TblTenderColumn> getTblTenderColumn()
        {
            return tblTenderColumn;
        }
        public void setTblTenderColumn(Set<TblTenderColumn> tblTenderColumn)
        {
            this.tblTenderColumn = tblTenderColumn;
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
        @Column(name="cstatus",nullable=false)
        public int getCstatus() {
            return this.cstatus;
        }

        public void setCstatus(int cstatus) {
            this.cstatus = cstatus;
        }
        @Column(name="formFooter",nullable=false)
        public String getFormFooter() {
            return this.formFooter;
        }

        public void setFormFooter(String formFooter) {
            this.formFooter = formFooter;
        }
        @Column(name="formHeader",nullable=false)
        public String getFormHeader() {
            return this.formHeader;
        }

        public void setFormHeader(String formHeader) {
            this.formHeader = formHeader;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="formId",unique=true,nullable=false)
        public int getFormId() {
            return this.formId;
        }

        public void setFormId(int formId) {
            this.formId = formId;
        }
        public TblTenderForm(int formId){
            this.formId = formId;
        }
        @Column(name="formName",nullable=false, length=500)
        public String getFormName() {
            return this.formName;
        }

        public void setFormName(String formName) {
            this.formName = formName;
        }
        
        @Column(name="incrementItems",nullable=false)
        public int getIncrementItems() {
            return this.incrementItems;
        }

        public void setIncrementItems(int incrementItems) {
            this.incrementItems = incrementItems;
        }

        @Column(name="isDocumentReq",nullable=false)
        public int getIsDocumentReq() {
            return this.isDocumentReq;
        }

        public void setIsDocumentReq(int isDocumentReq) {
            this.isDocumentReq = isDocumentReq;
        }
        @Column(name="isEncryptedDocument",nullable=false)
        public int getIsEncryptedDocument() {
            return this.isEncryptedDocument;
        }

        public void setIsEncryptedDocument(int isEncryptedDocument) {
            this.isEncryptedDocument = isEncryptedDocument;
        }
        @Column(name="isEncryptionReq",nullable=false)
        public int getIsEncryptionReq() {
            return this.isEncryptionReq;
        }

        public void setIsEncryptionReq(int isEncryptionReq) {
            this.isEncryptionReq = isEncryptionReq;
        }
        @Column(name="isEvaluationReq",nullable=false)
        public int getIsEvaluationReq() {
            return this.isEvaluationReq;
        }

        public void setIsEvaluationReq(int isEvaluationReq) {
            this.isEvaluationReq = isEvaluationReq;
        }
        @Column(name="isMandatory",nullable=false)
        public int getIsMandatory() {
            return this.isMandatory;
        }

        public void setIsMandatory(int isMandatory) {
            this.isMandatory = isMandatory;
        }
        @Column(name="isMultipleFilling",nullable=false)
        public int getIsMultipleFilling() {
            return this.isMultipleFilling;
        }

        public void setIsMultipleFilling(int isMultipleFilling) {
            this.isMultipleFilling = isMultipleFilling;
        }
        @Column(name="isPriceBid",nullable=false)
        public int getIsPriceBid() {
            return this.isPriceBid;
        }

        public void setIsPriceBid(int isPriceBid) {
            this.isPriceBid = isPriceBid;
        }
        @Column(name="isSecondary",nullable=false)
        public int getIsSecondary() {
            return this.isSecondary;
        }

        public void setIsSecondary(int isSecondary) {
            this.isSecondary = isSecondary;
        }
        
        @Column(name="loadNoOfItems",nullable=false)
        public Integer getLoadNoOfItems() {
            return this.loadNoOfItems;
        }

        public void setLoadNoOfItems(Integer loadNoOfItems) {
            this.loadNoOfItems = loadNoOfItems;
        }
        
        @Column(name="noOfTables",nullable=false)
        public int getNoOfTables() {
            return this.noOfTables;
        }

        public void setNoOfTables(int noOfTables) {
            this.noOfTables = noOfTables;
        }
        
        @Column(name="publishedBy",nullable=true)
        public Integer getPublishedBy() {
            return this.publishedBy;
        }

        public void setPublishedBy(Integer publishedBy) {
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
        
        @Column(name="sortOrder",nullable=false)
        public int getSortOrder() {
            return this.sortOrder;
        }

        public void setSortOrder(int sortOrder) {
            this.sortOrder = sortOrder;
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
        @Column(name="minTablesReqForBidding",nullable=false)
        public int getMinTablesReqForBidding() {
            return this.minTablesReqForBidding;
        }

        public void setMinTablesReqForBidding(int minTablesReqForBidding) {
            this.minTablesReqForBidding = minTablesReqForBidding;
        }
        @Column(name="isItemWiseDocAllowed",nullable=false)
        public int getIsItemWiseDocAllowed() {
			return isItemWiseDocAllowed;
		}

       	public void setIsItemWiseDocAllowed(int isItemWiseDocAllowed) {
			this.isItemWiseDocAllowed = isItemWiseDocAllowed;
		}
       	@Column(name="parentFormId",nullable=false)
        public int getParentFormId() {
			return parentFormId;
		}
       	public void setParentFormId(int parentFormId) {
			this.parentFormId = parentFormId;
		}
		
       	@Column(name="isCanceled")
        public Integer getIsCanceled() {
			return isCanceled;
		}

		public void setIsCanceled(Integer isCanceled) {
			this.isCanceled = isCanceled;
		}

		public TblTenderForm(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("cstatus", this.getCstatus())
.append("formFooter", this.getFormFooter())
.append("formHeader", this.getFormHeader())
.append("formId", this.getFormId())
.append("formName", this.getFormName())
.append("isDocumentReq", this.getIsDocumentReq())
.append("isEncryptedDocument", this.getIsEncryptedDocument())
.append("isEncryptionReq", this.getIsEncryptionReq())
.append("isEvaluationReq", this.getIsEvaluationReq())
.append("isMandatory", this.getIsMandatory())
.append("isMultipleFilling", this.getIsMultipleFilling())
.append("isPriceBid", this.getIsPriceBid())
.append("isSecondary", this.getIsSecondary())
.append("noOfTables", this.getNoOfTables())
.append("isItemWiseDocAllowed", this.getIsItemWiseDocAllowed())
.append("sortOrder", this.getSortOrder())
.append("parentFormId", this.getParentFormId())

		.toString();

	}
}
