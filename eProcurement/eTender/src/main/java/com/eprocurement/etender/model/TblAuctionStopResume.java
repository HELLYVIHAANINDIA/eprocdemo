/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author BigGoal
 */
@Entity
@Table(name="tbl_auctionstopresume")
public class TblAuctionStopResume {
    private int auctionstopresumeId;
    private String remark;
    private int status;
    private Date createdon;
    private int createdby;
    private Date auctionstartdate;
    private Date auctionenddate;
    private TblTender tblTender;
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="auctionstopresumeId",unique=true,nullable=false)
        public Integer getauctionstopresumeId() {
            return this.auctionstopresumeId;
        }
        public void setauctionstopresumeId(int auctionstopresumeId)
        {
            this.auctionstopresumeId=auctionstopresumeId;
        }
        
        @Column(name="remark")
        public String getremark()
        {
            return this.remark;
        }
        public void setremark(String remark)
        {
            this.remark=remark;
        }
        @Column(name="status")
        public int getstatus()
        {
            return this.status;
        }
        public void setstatus(int status)
        {
            this.status=status;
        }
        @Column(name="createdon")
        public Date getcreatedon()
        {
            return createdon;
        }
        public void setcreatedon(Date createdon)
        {
            this.createdon=createdon;
        }
        @Column(name="createdby")
        public int getcreatedby()
        {
            return this.createdby;
        }
        public void setcreatedby(int createdby)
        {
            this.createdby=createdby;
        }
        @Column(name="auctionstartdate")
        public Date getauctionstartdate()
        {
            return this.auctionstartdate;
        }
        public void setauctionstartdate(Date auctionstartdate)
        {
            this.auctionstartdate=auctionstartdate;
        }
        @Column(name="auctionenddate")
        public Date getauctionenddate()
        {
            return this.auctionenddate;
        }
        public void setauctionenddate(Date auctionenddate)
        {
            this.auctionenddate=auctionenddate;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="tenderId")
        public TblTender getTblTender() {
            return this.tblTender;
        }
        public void setTblTender(TblTender tblTender) {
            this.tblTender = tblTender;
        }
}
