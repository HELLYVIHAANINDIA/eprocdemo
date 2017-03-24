package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_fildnamemapping")
public class TblFildnameMapping  implements java.io.Serializable {

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="fieldid",unique=true,nullable=false)
    private Integer fieldId;
    @Column(name="labelname",nullable=false)
    private   String labelName;
    @Column(name="displayproperty",nullable=false)
    private   String displayProperty;
	
    public Integer getFieldId() {
		return fieldId;
	}
	public void setFieldId(Integer fieldId) {
		this.fieldId = fieldId;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}
	public String getDisplayProperty() {
		return displayProperty;
	}
	public void setDisplayProperty(String displayProperty) {
		this.displayProperty = displayProperty;
	}

	
}
