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
@Table(name="tbl_weightagereport")
public class TblWeightageReport implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="weightageId", nullable=false)
    private Integer    weightageId ;

    @Column(name="weightage", nullable=false)
    private Float weightage    ;
    
    @Column(name="rank", nullable=true)
    private String rank;
    
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderId", referencedColumnName="tenderId")
    private TblTender tblTender   ;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="companyId", referencedColumnName="companyid")
    private TblCompany tblCompany   ;

    
    public TblWeightageReport()
    {
		super();
    }


	public Integer getWeightageId() {
		return weightageId;
	}


	public void setWeightageId(Integer weightageId) {
		this.weightageId = weightageId;
	}


	public Float getWeightage() {
		return weightage;
	}


	public void setWeightage(Float weightage) {
		this.weightage = weightage;
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


	public String getRank() {
		return rank;
	}


	public void setRank(String rank) {
		this.rank = rank;
	}
}