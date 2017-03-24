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
@Table(name="tbl_tenderrebatedetail")
public class TblTenderRebateDetail  implements java.io.Serializable {

	private   int decryptionLevel;
	private   String rebateValue;
	private   TblTenderRebate tblTenderRebate;
	private   int tenderRebateDetailId;


	@Column(name="decryptionLevel",nullable=false)
	public int getDecryptionLevel() {
		return this.decryptionLevel;
	}

	public void setDecryptionLevel(int decryptionLevel) {
		this.decryptionLevel = decryptionLevel;
	}
	@Column(name="rebateValue",nullable=false, length=200)
	public String getRebateValue() {
		return this.rebateValue;
	}

	public void setRebateValue(String rebateValue) {
		this.rebateValue = rebateValue;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="tenderrebateid")
	public TblTenderRebate getTblTenderRebate() {
		return this.tblTenderRebate;
	}

	public void setTblTenderRebate(TblTenderRebate tblTenderRebate) {
		this.tblTenderRebate = tblTenderRebate;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="tenderRebateDetailId",unique=true,nullable=false)
	public int getTenderRebateDetailId() {
		return this.tenderRebateDetailId;
	}

	public void setTenderRebateDetailId(int tenderRebateDetailId) {
		this.tenderRebateDetailId = tenderRebateDetailId;
	}
	public TblTenderRebateDetail(int tenderRebateDetailId){
		this.tenderRebateDetailId = tenderRebateDetailId;
	}
	public TblTenderRebateDetail(){
	}
	@Override
	public String toString() {
		return new ToStringCreator(this)
		.append("decryptionLevel", this.getDecryptionLevel())
		.append("rebateValue", this.getRebateValue())

		.append("tenderRebateDetailId", this.getTenderRebateDetailId())
		.toString();

	}
}
