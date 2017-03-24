package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name="tbl_tenderformula")
public class TblTenderFormula  implements java.io.Serializable {

        private   int cellId;
        private   Integer cellNo;
        private   String colFormula;
        private   int columnNo;
        private   String displayFormula;
        private   String formula;
        private   int formulaId;
        private   int formulaType;
        private   TblTenderColumn tblTenderColumn;
        private   TblTenderForm tblTenderForm;
        private   TblTenderTable tblTenderTable;
        private   String validationMessage;


        @Column(name="cellId",nullable=false)
        public int getCellId() {
            return this.cellId;
        }

        public void setCellId(int cellId) {
            this.cellId = cellId;
        }
        @Column(name="cellNo",nullable=false)
        public Integer getCellNo() {
            return this.cellNo;
        }

        public void setCellNo(Integer cellNo) {
            this.cellNo = cellNo;
        }
        @Column(name="colFormula",nullable=false, length= -1)
        public String getColFormula() {
            return this.colFormula;
        }

        public void setColFormula(String colFormula) {
            this.colFormula = colFormula;
        }
        @Column(name="columnNo",nullable=false)
        public int getColumnNo() {
            return this.columnNo;
        }

        public void setColumnNo(int columnNo) {
            this.columnNo = columnNo;
        }
        @Column(name="displayFormula",nullable=false, length=0)
        public String getDisplayFormula() {
            return this.displayFormula;
        }

        public void setDisplayFormula(String displayFormula) {
            this.displayFormula = displayFormula;
        }
        @Column(name="formula",nullable=false, length= -1)
        public String getFormula() {
            return this.formula;
        }

        public void setFormula(String formula) {
            this.formula = formula;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="formulaId",unique=true,nullable=false)
        public int getFormulaId() {
            return this.formulaId;
        }

        public void setFormulaId(int formulaId) {
            this.formulaId = formulaId;
        }
        
        @Column(name="validationMessage",nullable=true, length=200)
        public String getValidationMessage() {
            return this.validationMessage;
        }

        public void setValidationMessage(String validationMessage) {
            this.validationMessage = validationMessage;
        }
        public TblTenderFormula(int formulaId){
            this.formulaId = formulaId;
        }
        @Column(name="formulaType",nullable=false)
        public int getFormulaType() {
            return this.formulaType;
        }

        public void setFormulaType(int formulaType) {
            this.formulaType = formulaType;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="columnid")
        public TblTenderColumn getTblTenderColumn() {
            return this.tblTenderColumn;
        }

        public void setTblTenderColumn(TblTenderColumn tblTenderColumn) {
            this.tblTenderColumn = tblTenderColumn;
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
        public TblTenderFormula(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("cellId", this.getCellId())
.append("cellNo", this.getCellNo())
.append("colFormula", this.getColFormula())
.append("columnNo", this.getColumnNo())
.append("displayFormula", this.getDisplayFormula())
.append("formula", this.getFormula())
.append("formulaId", this.getFormulaId())
.append("formulaType", this.getFormulaType())



		.toString();

	}
}
