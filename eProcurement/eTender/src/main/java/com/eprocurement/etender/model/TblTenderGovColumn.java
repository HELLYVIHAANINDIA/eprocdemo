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
@Table(name="tbl_tendergovcolumn")
public class TblTenderGovColumn  implements java.io.Serializable {

        private   int cellId;
        private   int columnNo;
        private   int govColumnId;
        private   String ipAddress;
        private   TblTender tblTender;
        private   TblTenderColumn tblTenderColumn;
        private   TblTenderForm tblTenderForm;
        private   TblTenderTable tblTenderTable;
        


        @Column(name="cellId",nullable=false)
        public int getCellId() {
            return this.cellId;
        }

        public void setCellId(int cellId) {
            this.cellId = cellId;
        }
        @Column(name="columnNo",nullable=false)
        public int getColumnNo() {
            return this.columnNo;
        }

        public void setColumnNo(int columnNo) {
            this.columnNo = columnNo;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="govColumnId",unique=true,nullable=false)
        public int getGovColumnId() {
            return this.govColumnId;
        }

        public void setGovColumnId(int govColumnId) {
            this.govColumnId = govColumnId;
        }
        public TblTenderGovColumn(int govColumnId){
            this.govColumnId = govColumnId;
        }
        @Column(name="ipAddress",nullable=false, length= 20)
        public String getIpAddress() {
            return this.ipAddress;
        }

        public void setIpAddress(String ipAddress) {
            this.ipAddress = ipAddress;
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
        
        public TblTenderGovColumn(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("cellId", this.getCellId())
.append("columnNo", this.getColumnNo())
.append("govColumnId", this.getGovColumnId())
.append("ipAddress", this.getIpAddress())




//.append("tenderId", this.getTenderId())
		.toString();

	}
}
