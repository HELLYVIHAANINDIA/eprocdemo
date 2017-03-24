package com.eprocurement.etender.model;

import java.math.BigDecimal;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name="tbl_tendermatrixjson")
public class TblTenderMatrixJson  implements java.io.Serializable {

        private   String jsonData;
        private   int matrixJsonId;
        private   TblTenderForm tblTenderForm;
        private   TblTenderTable tblTenderTable;


        @Column(name="jsonData",nullable=false, length=0)
        public String getJsonData() {
            return this.jsonData;
        }

        public void setJsonData(String jsonData) {
            this.jsonData = jsonData;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="matrixJsonId",unique=true,nullable=false)
        public int getMatrixJsonId() {
            return this.matrixJsonId;
        }

        public void setMatrixJsonId(int matrixJsonId) {
            this.matrixJsonId = matrixJsonId;
        }
        public TblTenderMatrixJson(int matrixJsonId){
            this.matrixJsonId = matrixJsonId;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="formid")
        public TblTenderForm getTblTenderForm() {
            return this.tblTenderForm;
        }

        public void setTblTenderForm(TblTenderForm tblTenderForm) {
            this.tblTenderForm = tblTenderForm;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tableid")
        public TblTenderTable getTblTenderTable() {
            return this.tblTenderTable;
        }

        public void setTblTenderTable(TblTenderTable tblTenderTable) {
            this.tblTenderTable = tblTenderTable;
        }
        public TblTenderMatrixJson(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("jsonData", this.getJsonData())
.append("matrixJsonId", this.getMatrixJsonId())


		.toString();

	}
}
