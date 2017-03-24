
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "tbl_tenderbiddermap")
public class TblTenderBidderMap implements java.io.Serializable {

    private int createdBy;
    private Date createdOn;
    private String ipAddress;
    private int mapBidderId;
    private TblTender tblTender;
    private TblUserLogin tblUserLogin;
    private TblBidder tblBidder;

    @Column(name = "createdBy", nullable = false)
    public int getCreatedBy() {
        return this.createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createdOn", nullable = false)
    public Date getCreatedOn() {
        return this.createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Column(name = "ipAddress", nullable = false, length = 20)
    public String getIpAddress() {
        return this.ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mapBidderId", unique = true, nullable = false)
    public int getMapBidderId() {
        return this.mapBidderId;
    }

    public void setMapBidderId(int mapBidderId) {
        this.mapBidderId = mapBidderId;
    }

    public TblTenderBidderMap(int mapBidderId) {
        this.mapBidderId = mapBidderId;
    }

    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenderid")
    public TblTender getTblTender() {
        return this.tblTender;
    }

    public void setTblTender(TblTender tblTender) {
        this.tblTender = tblTender;
    }

    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    public TblUserLogin getTblUserLogin() {
        return this.tblUserLogin;
    }

    public void setTblUserLogin(TblUserLogin tblUserLogin) {
        this.tblUserLogin = tblUserLogin;
    }
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bidderId")
    public TblBidder getTblBidder() {
        return this.tblBidder;
    }

    public void setTblBidder(TblBidder tblBidder) {
        this.tblBidder = tblBidder;
    }
    

    public TblTenderBidderMap() {
    }

    @Override
    public String toString() {
        return new ToStringCreator(this)
                .append("createdBy", this.getCreatedBy())
                .append("createdOn", this.getCreatedOn())
                .append("ipAddress", this.getIpAddress())
                .append("mapBidderId", this.getMapBidderId())
                .toString();

    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final TblTenderBidderMap other = (TblTenderBidderMap) obj;
        if(tblTender!=null){
        if (this.tblTender.getTenderId() != other.tblTender.getTenderId() && (this.tblTender == null || !this.tblTender.equals(other.tblTender))) {
            return false;
        }
        }
        
        if(tblUserLogin!=null){
        if (this.tblUserLogin.getUserId() != other.tblUserLogin.getUserId() && (this.tblUserLogin == null || !this.tblUserLogin.equals(other.tblUserLogin))) {
            return false;
        }
        }
        return true;
    }

    @Override
    public int hashCode() {
        int tenderBidderMapHash=0;
        if(tblTender!=null){
        		tenderBidderMapHash+=((Integer)this.tblTender.getTenderId()).hashCode();
        }
        return tenderBidderMapHash;
    } 
}
