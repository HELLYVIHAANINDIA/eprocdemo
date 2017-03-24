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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.core.style.ToStringCreator;

import com.eprocurement.common.model.TblColumnType;

@Entity
@Table(name="tbl_biddetail")
public class TblBidDetail  implements java.io.Serializable {

        private   int bidDetailId;
        private   int cellId;
        private   String cellValue;
        private   TblCompany tblCompany;
        private   TblTenderForm tblTenderForm;
        private TblTenderColumn tblTenderColumn;


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="bidDetailId",unique=true,nullable=false)
        public int getBidDetailId() {
            return this.bidDetailId;
        }

        public void setBidDetailId(int bidDetailId) {
            this.bidDetailId = bidDetailId;
        }
        
        
       
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="companyId")
        public TblCompany getTblCompany() {
			return tblCompany;
		}

		public void setTblCompany(TblCompany tblCompany) {
			this.tblCompany = tblCompany;
		}
                @ManyToOne(fetch=FetchType.LAZY)
                @JoinColumn(name="columnid")
                public TblTenderColumn getTblTenderColumn(){
                return tblTenderColumn;
                }
                public void setTblTenderColumn(TblTenderColumn tblTenderColumn){
                this.tblTenderColumn=tblTenderColumn;
                }

		@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="formId")
		public TblTenderForm getTblTenderForm() {
			return tblTenderForm;
		}

		public void setTblTenderForm(TblTenderForm tblTenderForm) {
			this.tblTenderForm = tblTenderForm;
		}


		public TblBidDetail(int bidDetailId){
            this.bidDetailId = bidDetailId;
        }
        @Column(name="cellId",nullable=false)
        public int getCellId() {
            return this.cellId;
        }

        public void setCellId(int cellId) {
            this.cellId = cellId;
        }
        
        @Column(name="cellValue",nullable=false, length=0)
        public String getCellValue() {
            return this.cellValue;
        }

        public void setCellValue(String cellValue) {
            this.cellValue = cellValue;
        }
       
        public TblBidDetail(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("bidDetailId", this.getBidDetailId())
.append("cellId", this.getCellId())
.append("cellValue", this.getCellValue())
		.toString();

	}
}
