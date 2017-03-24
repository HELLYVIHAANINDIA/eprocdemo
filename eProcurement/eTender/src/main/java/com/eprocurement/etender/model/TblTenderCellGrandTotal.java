/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.model;

import java.io.Serializable;
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

/**
 *
 * @author BigGoal
 */
@Entity
@Table(name="tbl_tendercellgrandtotal")
public class TblTenderCellGrandTotal implements Serializable{
    int cellGrandTotalId;
    TblTenderTable tblTenderTable;
    TblTenderForm tblTenderForm;
    TblTender tblTender;
    TblTenderColumn tblTenderColumn;
    TblBidder tblBidder;
    String GTValue;
    
    
    
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="cellGrandTotalId",unique=true, nullable=false)
    public int getCellGrandTotalId() {
		return cellGrandTotalId;
	}

	public void setCellGrandTotalId(int cellGrandTotalId) {
		this.cellGrandTotalId = cellGrandTotalId;
	}
	 @ManyToOne(fetch=FetchType.LAZY)
	    @JoinColumn(name="tableId")
	public TblTenderTable getTblTenderTable() {
		return tblTenderTable;
	}

	public void setTblTenderTable(TblTenderTable tblTenderTable) {
		this.tblTenderTable = tblTenderTable;
	}

	public TblTenderCellGrandTotal(){
    }
    
    public TblTenderCellGrandTotal(int cellGrandTotalId){
        this.cellGrandTotalId = cellGrandTotalId;
    }
    
    @Column(name="GTValue")
    public String getGTValue()
    {
        return this.GTValue;
    }
    public void setGTValue(String GTValue)
    {
        this.GTValue=GTValue;
    }
    	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="formId")
        public TblTenderForm getTblTenderForm() {
            return this.tblTenderForm;
        }

        public void setTblTenderForm(TblTenderForm tblTenderForm) {
            this.tblTenderForm = tblTenderForm;
        }
    
        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderId")
        public TblTender getTblTender() {
            return this.tblTender;
        }
        
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="bidderId")
        public TblBidder getTblBidder() {
            return this.tblBidder;
        }

        public void setTblBidder(TblBidder tblBidder) {
            this.tblBidder = tblBidder;
        }
        
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="columnId")
        public TblTenderColumn getTblTenderColumn() {
            return this.tblTenderColumn;
        }

        public void setTblTenderColumn(TblTenderColumn tblTenderColumn) {
            this.tblTenderColumn = tblTenderColumn;
        }

        @Override
    	public String toString() {
    		return new ToStringCreator(this)
		    .append("cellGrandTotalId", this.getCellGrandTotalId())
//		    .append("tblTenderTable", this.getTblTenderTable())
//		    .append("tblTenderForm", this.getTblTenderForm())
//		    .append("tblTender", this.getTblTender())
//		    .append("tblTenderColumn", this.getTblTenderColumn())
//		    .append("tblBidder", this.getTblBidder())
		    .append("GTValue", this.getGTValue())
    		.toString();
        }
    		
		/*@Override
		public String toString() {
			return "TblTenderCellGrandTotal [cellGrandTotalId="
					+ cellGrandTotalId + ", tblTenderTable=" + tblTenderTable
					+ ", tblTenderForm=" + tblTenderForm + ", tblTender="
					+ tblTender + ", tblTenderColumn=" + tblTenderColumn
					+ ", tblBidder=" + tblBidder + ", GTValue=" + GTValue + "]";
		}
*/
        

        
}