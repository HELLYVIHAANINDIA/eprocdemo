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


@Entity
@Table(name="tbl_l1h1report")
public class TblL1H1Report implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="l1h1Id", nullable=false)
    private Integer    l1h1Id ;

    @Column(name="rank", nullable=false)
    private String    rank    ;

    @Column(name="tableId", nullable=true)
    private Integer    tableId    ;
    
    @Column(name="rowId", nullable=true)
    private Integer    rowId    ;
    
    @Column(name="amount", nullable=false)
    private String     amount      ;

    @Column(name="amountAfterRebate")
    private String    amountAfterRebate    ;

    @Column(name="filledByOfficers")
    private String    filledByOfficers    ;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderId", referencedColumnName="tenderId")
    private TblTender tblTender   ;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="companyId", referencedColumnName="companyid")
    private TblCompany tblCompany   ;

    
    public TblL1H1Report()
    {
		super();
    }


	public Integer getL1h1Id() {
		return l1h1Id;
	}


	public void setL1h1Id(Integer l1h1Id) {
		this.l1h1Id = l1h1Id;
	}


	public String getRank() {
		return rank;
	}


	public void setRank(String rank) {
		this.rank = rank;
	}


	public String getAmount() {
		return amount;
	}


	public void setAmount(String amount) {
		this.amount = amount;
	}


	public String getAmountAfterRebate() {
		return amountAfterRebate;
	}


	public void setAmountAfterRebate(String amountAfterRebate) {
		this.amountAfterRebate = amountAfterRebate;
	}


	public TblTender getTblTender() {
		return tblTender;
	}


	public void setTblTender(TblTender tblTender) {
		this.tblTender = tblTender;
	}


	public TblCompany getTblCompany() {
		return tblCompany;
	}


	public void setTblCompany(TblCompany tblCompany) {
		this.tblCompany = tblCompany;
	}


	public Integer getTableId() {
		return tableId;
	}


	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}


	public Integer getRowId() {
		return rowId;
	}


	public void setRowId(Integer rowId) {
		this.rowId = rowId;
	}


	public String getFilledByOfficers() {
		return filledByOfficers;
	}


	public void setFilledByOfficers(String filledByOfficers) {
		this.filledByOfficers = filledByOfficers;
	}


	@Override
	public String toString() {
		return "TblL1H1Report [l1h1Id=" + l1h1Id + ", rank=" + rank
				+ ", tableId=" + tableId + ", rowId=" + rowId + ", amount="
				+ amount + ", amountAfterRebate=" + amountAfterRebate
				+ ", filledByOfficers=" + filledByOfficers + ", tblTender="
				+ tblTender + ", tblCompany=" + tblCompany + "]";
	}
    
    
    
   
}