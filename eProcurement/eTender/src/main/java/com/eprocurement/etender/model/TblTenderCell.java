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

@Entity
@Table(name="tbl_tendercell")
public class TblTenderCell  implements java.io.Serializable {

        private   int cellId;
        private   Integer cellNo;
        private   String cellValue;
        private   int dataType;
        private   int objectId;
        private   int rowId;
        private   TblTenderColumn tblTenderColumn;
        private   TblTenderForm tblTenderForm;
        private   TblTenderTable tblTenderTable;

       
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="cellId",unique=true,nullable=false)
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
        @Column(name="cellValue",nullable=false, length=0)
        public String getCellValue() {
            return this.cellValue;
        }

        public void setCellValue(String cellValue) {
            this.cellValue = cellValue;
        }
        @Column(name="dataType",nullable=false)
        public int getDataType() {
            return this.dataType;
        }

        public void setDataType(int dataType) {
            this.dataType = dataType;
        }
        @Column(name="objectId",nullable=false)
        public int getObjectId() {
            return this.objectId;
        }

        public void setObjectId(int objectId) {
            this.objectId = objectId;
        }
        @Column(name="rowId",nullable=false)
        public int getRowId() {
            return this.rowId;
        }

        public void setRowId(int rowId) {
            this.rowId = rowId;
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
        public TblTenderCell(){
        	
        }
        
        
        public TblTenderCell(int cellId){
        	this.cellId=cellId;
        }
        
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("cellId", this.getCellId())
.append("cellNo", this.getCellNo())
.append("cellValue", this.getCellValue())
.append("dataType", this.getDataType())
.append("objectId", this.getObjectId())
.append("rowId", this.getRowId())



		.toString();

	}
        public TblTenderCell(int cellId, Integer cellNo, TblTenderColumn tblTenderColumn, Integer dataType, Integer rowId, TblTenderTable tblTenderTable, String cellValue,int objectId) {
        this.cellId = cellId;
        this.cellNo = cellNo;        
        this.tblTenderColumn = tblTenderColumn;
        this.dataType = dataType;
        if(dataType==8 || dataType==6 || dataType==9){
            this.objectId=Integer.parseInt(cellValue);
        }else{
            this.objectId=objectId;
        }
        this.rowId = rowId;
        this.tblTenderTable = tblTenderTable;
        this.cellValue = cellValue;
    }
}
