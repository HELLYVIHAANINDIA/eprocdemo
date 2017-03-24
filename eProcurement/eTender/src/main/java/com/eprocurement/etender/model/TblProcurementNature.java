package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_procurementnature")
public class TblProcurementNature  implements java.io.Serializable {

	  @Id
	  @GeneratedValue(strategy = GenerationType.IDENTITY)
	  @Column(name="procurementNatureId",unique=true,nullable=false)
	  private Integer procurementNatureId;
	  @Column(name="procurementName",nullable=false)
	  private   String procurementName;
	  @Column(name="cStatus",nullable=false)
	  private   int cStatus;
		
	public TblProcurementNature(int parseInt) {
		// TODO Auto-generated constructor stub
		this.setProcurementNatureId(parseInt);
	}
	public Integer getProcurementNatureId() {
		return procurementNatureId;
	}
	public void setProcurementNatureId(Integer procurementNatureId) {
		this.procurementNatureId = procurementNatureId;
	}
	
	public String getProcurementName() {
		return procurementName;
	}
	public void setProcurementName(String procurementName) {
		this.procurementName = procurementName;
	}
	public int getcStatus() {
		return cStatus;
	}
	public void setcStatus(int cStatus) {
		this.cStatus = cStatus;
	}
}
