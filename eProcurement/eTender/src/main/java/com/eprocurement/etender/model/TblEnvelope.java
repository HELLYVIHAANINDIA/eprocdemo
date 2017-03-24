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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name="tbl_envelope")
public class TblEnvelope  implements java.io.Serializable {

	private   int envId;
	private   int isActive;
	private   String lang1;
	private   String lang10;
	private   String lang11;
	private   String lang12;
	private   String lang13;
	private   String lang14;
	private   String lang15;
	private   String lang2;
	private   String lang3;
	private   String lang4;
	private   String lang5;
	private   String lang6;
	private   String lang7;
	private   String lang8;
	private   String lang9;
	private   int sortOrder;

	private Set<TblTenderEnvelope> tblTenderEnvelope = new HashSet<TblTenderEnvelope>();

	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblEnvelope")
	public Set<TblTenderEnvelope> getTblTenderEnvelope()
	{
		return tblTenderEnvelope;
	}
	public void setTblTenderEnvelope(Set<TblTenderEnvelope> tblTenderEnvelope)
	{
		this.tblTenderEnvelope = tblTenderEnvelope;
	}


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="envId",unique=true,nullable=false)
	public int getEnvId() {
		return this.envId;
	}

	public void setEnvId(int envId) {
		this.envId = envId;
	}
	public TblEnvelope(int envId){
		this.envId = envId;
	}
	@Column(name="isActive",nullable=false)
	public int getIsActive() {
		return this.isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	@Column(name="lang1",nullable=true, length=50)
	public String getLang1() {
		return this.lang1;
	}

	public void setLang1(String lang1) {
		this.lang1 = lang1;
	}
	@Column(name="lang10",nullable=true, length=50)
	public String getLang10() {
		return this.lang10;
	}

	public void setLang10(String lang10) {
		this.lang10 = lang10;
	}
	@Column(name="lang11",nullable=true, length=50)
	public String getLang11() {
		return this.lang11;
	}

	public void setLang11(String lang11) {
		this.lang11 = lang11;
	}
	@Column(name="lang12",nullable=true, length=50)
	public String getLang12() {
		return this.lang12;
	}

	public void setLang12(String lang12) {
		this.lang12 = lang12;
	}
	@Column(name="lang13",nullable=true, length=50)
	public String getLang13() {
		return this.lang13;
	}

	public void setLang13(String lang13) {
		this.lang13 = lang13;
	}
	@Column(name="lang14",nullable=true, length=50)
	public String getLang14() {
		return this.lang14;
	}

	public void setLang14(String lang14) {
		this.lang14 = lang14;
	}
	@Column(name="lang15",nullable=true, length=50)
	public String getLang15() {
		return this.lang15;
	}

	public void setLang15(String lang15) {
		this.lang15 = lang15;
	}
	@Column(name="lang2",nullable=true, length=50)
	public String getLang2() {
		return this.lang2;
	}

	public void setLang2(String lang2) {
		this.lang2 = lang2;
	}
	@Column(name="lang3",nullable=true, length=50)
	public String getLang3() {
		return this.lang3;
	}

	public void setLang3(String lang3) {
		this.lang3 = lang3;
	}
	@Column(name="lang4",nullable=true, length=50)
	public String getLang4() {
		return this.lang4;
	}

	public void setLang4(String lang4) {
		this.lang4 = lang4;
	}
	@Column(name="lang5",nullable=true, length=50)
	public String getLang5() {
		return this.lang5;
	}

	public void setLang5(String lang5) {
		this.lang5 = lang5;
	}
	@Column(name="lang6",nullable=true, length=50)
	public String getLang6() {
		return this.lang6;
	}

	public void setLang6(String lang6) {
		this.lang6 = lang6;
	}
	@Column(name="lang7",nullable=true, length=50)
	public String getLang7() {
		return this.lang7;
	}

	public void setLang7(String lang7) {
		this.lang7 = lang7;
	}
	@Column(name="lang8",nullable=true, length=50)
	public String getLang8() {
		return this.lang8;
	}

	public void setLang8(String lang8) {
		this.lang8 = lang8;
	}
	@Column(name="lang9",nullable=true, length=50)
	public String getLang9() {
		return this.lang9;
	}

	public void setLang9(String lang9) {
		this.lang9 = lang9;
	}
	@Column(name="sortOrder",nullable=false)
	public int getSortOrder() {
		return this.sortOrder;
	}

	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	public TblEnvelope(){
	}
	@Override
	public String toString() {
		return new ToStringCreator(this)
		.append("envId", this.getEnvId())
		.append("isActive", this.getIsActive())
		.append("lang1", this.getLang1())
		.append("lang10", this.getLang10())
		.append("lang11", this.getLang11())
		.append("lang12", this.getLang12())
		.append("lang13", this.getLang13())
		.append("lang14", this.getLang14())
		.append("lang15", this.getLang15())
		.append("lang2", this.getLang2())
		.append("lang3", this.getLang3())
		.append("lang4", this.getLang4())
		.append("lang5", this.getLang5())
		.append("lang6", this.getLang6())
		.append("lang7", this.getLang7())
		.append("lang8", this.getLang8())
		.append("lang9", this.getLang9())
		.append("sortOrder", this.getSortOrder())
		.toString();

	}
}
