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
@Table(name="Tbl_TenderBidCurrency")
public class TblTenderBidCurrency  implements java.io.Serializable {

        private   int bidCurrencyId;
        private   TblCompany tblCompany;
        private   TblTenderCurrency tblTenderCurrency;
        private   int userId;


        public int getUserId() {
			return userId;
		}

		public void setUserId(int userId) {
			this.userId = userId;
		}

		@Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="bidCurrencyId",unique=true,nullable=false)
        public int getBidCurrencyId() {
            return this.bidCurrencyId;
        }

        public void setBidCurrencyId(int bidCurrencyId) {
            this.bidCurrencyId = bidCurrencyId;
        }
        public TblTenderBidCurrency(int bidCurrencyId){
            this.bidCurrencyId = bidCurrencyId;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="companyid")
        public TblCompany getTblCompany() {
            return this.tblCompany;
        }

        public void setTblCompany(TblCompany tblCompany) {
            this.tblCompany = tblCompany;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tendercurrencyid")
        public TblTenderCurrency getTblTenderCurrency() {
            return this.tblTenderCurrency;
        }

        public void setTblTenderCurrency(TblTenderCurrency tblTenderCurrency) {
            this.tblTenderCurrency = tblTenderCurrency;
        }
        public TblTenderBidCurrency(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("bidCurrencyId", this.getBidCurrencyId())



		.toString();

	}
}
