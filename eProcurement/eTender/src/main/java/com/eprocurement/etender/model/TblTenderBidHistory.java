/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.model;

import java.io.Serializable;
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
@Table(name="tbl_tenderbidhistory")
public class TblTenderBidHistory implements Serializable{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="bidHistoryId",unique=true, nullable=false)
    Integer bidHistoryId;
    
    @Column(name="bidValue")
    String bidValue;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="bidderId", referencedColumnName="bidderId")
    TblBidder tblBidder;
    
    @Column(name="biddateTime")
    Date bidDateTime;
    
    @Column(name="isValid")
    Integer isValid;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderId", referencedColumnName="tenderId")
    TblTender tblTender;
    
    @Column(name="isAuction")
    Integer isAuction;

    public Integer getBidHistoryId() {
        return bidHistoryId;
    }

    public void setBidHistoryId(Integer bidHistoryId) {
        this.bidHistoryId = bidHistoryId;
    }

    public String getBidValue() {
        return bidValue;
    }

    public void setBidValue(String bidValue) {
        this.bidValue = bidValue;
    }

    public TblBidder getTblBidder() {
        return tblBidder;
    }

    public void setTblBidder(TblBidder tblBidder) {
        this.tblBidder = tblBidder;
    }

    public Date getBidDateTime() {
        return bidDateTime;
    }

    public void setBidDateTime(Date bidDateTime) {
        this.bidDateTime = bidDateTime;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }

    public TblTender getTblTender() {
        return tblTender;
    }

    public void setTblTender(TblTender tblTender) {
        this.tblTender = tblTender;
    }

    public Integer getIsAuction() {
        return isAuction;
    }

    public void setIsAuction(Integer isAuction) {
        this.isAuction = isAuction;
    }
    
    
    
}
