package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_currency")
public class TblCurrency  implements java.io.Serializable {

	  @Id
	  @GeneratedValue(strategy = GenerationType.IDENTITY)
	  @Column(name="currencyId",unique=true,nullable=false)
	  private Integer currencyId;
	  @Column(name="currencyName",nullable=false)
	  private   String currencyName;
	  @Column(name="isActive",nullable=false)
	  private   int isActive;
	  
	  public TblCurrency(){
      }
	  
	  public TblCurrency(int currencyId){
		  this.currencyId=currencyId;
      }
	  public Integer getCurrencyId() {
			return currencyId;
		}
		public void setCurrencyId(Integer currencyId) {
			this.currencyId = currencyId;
		}
		public String getCurrencyName() {
			return currencyName;
		}
		public void setCurrencyName(String currencyName) {
			this.currencyName = currencyName;
		}
		public int getIsActive() {
			return isActive;
		}
		public void setIsActive(int isActive) {
			this.isActive = isActive;
		}

}
