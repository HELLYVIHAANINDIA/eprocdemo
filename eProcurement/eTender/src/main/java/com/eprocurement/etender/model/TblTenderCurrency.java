package com.eprocurement.etender.model;

import java.math.BigDecimal;

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
@Table(name="tbl_tendercurrency")
public class TblTenderCurrency  implements java.io.Serializable {

        private   BigDecimal exchangeRate;
        private   int isActive;
        private   int isDefault;
        private   TblCurrency tblCurrency;
        private   TblTender tblTender;
        private   int tenderCurrencyId;
        private   TblTenderBidCurrency tblTenderBidCurrency;

        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="bidCurrencyId")
        public TblTenderBidCurrency getTblTenderBidCurrency() {
			return tblTenderBidCurrency;
		}

		public void setTblTenderBidCurrency(TblTenderBidCurrency tblTenderBidCurrency) {
			this.tblTenderBidCurrency = tblTenderBidCurrency;
		}

		@Column(name="exchangeRate",nullable=false)
        public BigDecimal getExchangeRate() {
            return this.exchangeRate;
        }

        public void setExchangeRate(BigDecimal exchangeRate) {
            this.exchangeRate = exchangeRate;
        }
        @Column(name="isActive",nullable=false)
        public int getIsActive() {
            return this.isActive;
        }

        public void setIsActive(int isActive) {
            this.isActive = isActive;
        }
        @Column(name="isDefault",nullable=false)
        public int getIsDefault() {
            return this.isDefault;
        }

        public void setIsDefault(int isDefault) {
            this.isDefault = isDefault;
        }
        
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderid")
        public TblTender getTblTender() {
            return this.tblTender;
        }

        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
        /**
         * @return
         */
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="tenderCurrencyId",unique=true,nullable=false)
        public int getTenderCurrencyId() {
            return this.tenderCurrencyId;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="currencyId")
        public TblCurrency getTblCurrency() {
			return tblCurrency;
		}

		public void setTblCurrency(TblCurrency tblCurrency) {
			this.tblCurrency = tblCurrency;
		}

		public void setTenderCurrencyId(int tenderCurrencyId) {
            this.tenderCurrencyId = tenderCurrencyId;
        }
        public TblTenderCurrency(int tenderCurrencyId){
            this.tenderCurrencyId = tenderCurrencyId;
        }
        public TblTenderCurrency(){
        }

}
