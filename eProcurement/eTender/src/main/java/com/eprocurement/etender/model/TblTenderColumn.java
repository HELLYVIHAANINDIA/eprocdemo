package com.eprocurement.etender.model;

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

import org.springframework.core.style.ToStringCreator;

import com.eprocurement.common.model.TblColumnType;

@Entity
@Table(name="tbl_tendercolumn")
public class TblTenderColumn  implements java.io.Serializable {

        private   String columnHeader;
        private   int columnId;
        private   int columnNo;
        private   int dataType;
        private   int filledBy;
        private   int isCurrConvReq;
        private   int isShown;
        private   int sortOrder;
        private int isGTColumn;
        private int isPriceSummary;
        private   TblColumnType tblColumnType;
        private   TblTenderForm tblTenderForm;
        private   TblTenderTable tblTenderTable;

        

        private Set<TblTenderFormula> tblTenderFormula = new HashSet<TblTenderFormula>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderColumn")
        public Set<TblTenderFormula> getTblTenderFormula()
        {
            return tblTenderFormula;
        }
        public void setTblTenderFormula(Set<TblTenderFormula> tblTenderFormula)
        {
            this.tblTenderFormula = tblTenderFormula;
        }

        private Set<TblTenderCell> tblTenderCell = new HashSet<TblTenderCell>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderColumn")
        public Set<TblTenderCell> getTblTenderCell()
        {
            return tblTenderCell;
        }
        public void setTblTenderCell(Set<TblTenderCell> tblTenderCell)
        {
            this.tblTenderCell = tblTenderCell;
        }

        private Set<TblTenderGovColumn> tblTenderGovColumn = new HashSet<TblTenderGovColumn>();

        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTenderColumn")
        public Set<TblTenderGovColumn> getTblTenderGovColumn()
        {
            return tblTenderGovColumn;
        }
        public void setTblTenderGovColumn(Set<TblTenderGovColumn> tblTenderGovColumn)
        {
            this.tblTenderGovColumn = tblTenderGovColumn;
        }


        @Column(name="columnHeader",nullable=false, length=300)
        public String getColumnHeader() {
            return this.columnHeader;
        }

        public void setColumnHeader(String columnHeader) {
            this.columnHeader = columnHeader;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="columnId",unique=true,nullable=false)
        public int getColumnId() {
            return this.columnId;
        }

        public void setColumnId(int columnId) {
            this.columnId = columnId;
        }
        public TblTenderColumn(int columnId){
            this.columnId = columnId;
        }
        @Column(name="columnNo",nullable=false)
        public int getColumnNo() {
            return this.columnNo;
        }

        public void setColumnNo(int columnNo) {
            this.columnNo = columnNo;
        }
        @Column(name="dataType",nullable=false)
        public int getDataType() {
            return this.dataType;
        }

        public void setDataType(int dataType) {
            this.dataType = dataType;
        }
        @Column(name="filledBy",nullable=false)
        public int getFilledBy() {
            return this.filledBy;
        }

        public void setFilledBy(int filledBy) {
            this.filledBy = filledBy;
        }
        @Column(name="isCurrConvReq",nullable=false)
        public int getIsCurrConvReq() {
            return this.isCurrConvReq;
        }

        public void setIsCurrConvReq(int isCurrConvReq) {
            this.isCurrConvReq = isCurrConvReq;
        }
        @Column(name="isShown",nullable=false)
        public int getIsShown() {
            return this.isShown;
        }

        public void setIsShown(int isShown) {
            this.isShown = isShown;
        }
        @Column(name="sortOrder",nullable=false)
        public int getSortOrder() {
            return this.sortOrder;
        }

        public void setSortOrder(int sortOrder) {
            this.sortOrder = sortOrder;
        }
        
        @Column(name="isGTColumn",nullable=true)
        
        public int getisGTColumn() {
            return this.isGTColumn;
        }

        public void setisGTColumn(int isGTColumn) {
            this.isGTColumn = isGTColumn;
        }
        
         @Column(name="isPriceSummary")
        public int getIsPriceSummary() {
            return this.isPriceSummary;
        }

        public void setIsPriceSummary(int isPriceSummary) {
            this.isPriceSummary = isPriceSummary;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="columntypeid")
        public TblColumnType getTblColumnType() {
            return this.tblColumnType;
        }

        public void setTblColumnType(TblColumnType tblColumnType) {
            this.tblColumnType = tblColumnType;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="formid")
        public TblTenderForm getTblTenderForm() {
            return this.tblTenderForm;
        }

        public void setTblTenderForm(TblTenderForm tblTenderForm) {
            this.tblTenderForm = tblTenderForm;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tableid")
        public TblTenderTable getTblTenderTable() {
            return this.tblTenderTable;
        }

        public void setTblTenderTable(TblTenderTable tblTenderTable) {
            this.tblTenderTable = tblTenderTable;
        }
        public TblTenderColumn(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("columnHeader", this.getColumnHeader())
.append("columnId", this.getColumnId())
.append("columnNo", this.getColumnNo())
.append("dataType", this.getDataType())
.append("filledBy", this.getFilledBy())
.append("isCurrConvReq", this.getIsCurrConvReq())
.append("isShown", this.getIsShown())
.append("sortOrder", this.getSortOrder())



		.toString();

	}
}
