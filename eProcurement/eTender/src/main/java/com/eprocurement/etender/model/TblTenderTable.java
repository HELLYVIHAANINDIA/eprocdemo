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
@Table(name="tbl_tendertable")
public class TblTenderTable  implements java.io.Serializable {

        private   int createdBy;
        private   Date createdOn;
        private   int hasGTRow;
        private   int isMultipleFilling;
        private   int isPartialFillingAllowed;
        private   int isMandatory;
        private   int noOfCols;
        private   int noOfRows;
        private   int sortOrder;
        private   String tableFooter;
        private   String tableHeader;
        private   int tableId;
        private   String tableName;
        private   int formId;
        private   int updatedBy;
        private   Date updatedOn;

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
        @Column(name="hasGTRow",nullable=false)
        public int getHasGTRow() {
            return this.hasGTRow;
        }

        public void setHasGTRow(int hasGTRow) {
            this.hasGTRow = hasGTRow;
        }
        @Column(name="isMultipleFilling",nullable=false)
        public int getIsMultipleFilling() {
            return this.isMultipleFilling;
        }

        public void setIsMultipleFilling(int isMultipleFilling) {
            this.isMultipleFilling = isMultipleFilling;
        }
        @Column(name="noOfCols",nullable=false)
        public int getNoOfCols() {
            return this.noOfCols;
        }

        public void setNoOfCols(int noOfCols) {
            this.noOfCols = noOfCols;
        }
        @Column(name="noOfRows",nullable=false)
        public int getNoOfRows() {
            return this.noOfRows;
        }

        public void setNoOfRows(int noOfRows) {
            this.noOfRows = noOfRows;
        }
        @Column(name="sortOrder",nullable=false)
        public int getSortOrder() {
            return this.sortOrder;
        }

        public void setSortOrder(int sortOrder) {
            this.sortOrder = sortOrder;
        }
        @Column(name="tableFooter",nullable=false)
        public String getTableFooter() {
            return this.tableFooter;
        }

        public void setTableFooter(String tableFooter) {
            this.tableFooter = tableFooter;
        }
        @Column(name="tableHeader",nullable=false)
        public String getTableHeader() {
            return this.tableHeader;
        }

        public void setTableHeader(String tableHeader) {
            this.tableHeader = tableHeader;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="tableId",unique=true,nullable=false)
        public int getTableId() {
            return this.tableId;
        }

        public void setTableId(int tableId) {
            this.tableId = tableId;
        }
        public TblTenderTable(int tableId){
            this.tableId = tableId;
        }
        @Column(name="tableName",nullable=false, length=500)
        public String getTableName() {
            return this.tableName;
        }

        public void setTableName(String tableName) {
            this.tableName = tableName;
        }
       
        @Column(name="updatedBy",nullable=false)
        public int getUpdatedBy() {
            return this.updatedBy;
        }

        public void setUpdatedBy(int updatedBy) {
            this.updatedBy = updatedBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="updatedOn",nullable=false)
        public Date getUpdatedOn() {
            return this.updatedOn;
        }

        public void setUpdatedOn(Date updatedOn) {
            this.updatedOn = updatedOn;
        }
        @Column(name="isPartialFillingAllowed",nullable=false)
        public int getIsPartialFillingAllowed() {
            return this.isPartialFillingAllowed;
        }
        public void setIsPartialFillingAllowed(int isPartialFillingAllowed) {
            this.isPartialFillingAllowed = isPartialFillingAllowed;
        }
        @Column(name="isMandatory",nullable=false)
        public int getIsMandatory() {
            return this.isMandatory;
        }
        public void setIsMandatory(int isMandatory) {
            this.isMandatory = isMandatory;
        }
        
        @Column(name="formId",nullable=false)
        public int getFormId() {
			return formId;
		}

		public void setFormId(int formId) {
			this.formId = formId;
		}

		public TblTenderTable(){
        }
        
}
