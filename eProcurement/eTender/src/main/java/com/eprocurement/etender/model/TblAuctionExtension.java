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
@Table(name="tbl_auctionExtension")
public class TblAuctionExtension implements Serializable {
    private int auctionExtensionId;
    private Date extensionStartTime;
    private Date extensionEndTime;
    private TblTender tblTender;
    
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="auctionExtensionId",unique=true, nullable=false)
    public int getauctionExtensionId()
    {
        return this.auctionExtensionId;
    }
    
    public void setauctionExtensionId(int auctionExtensionId)
    {
        this.auctionExtensionId=auctionExtensionId;
    }
    
    @Column(name="ExtensionStartTime")
    public Date getExtensionStartTime()
    {
        return this.extensionStartTime;
    }
    public void setExtensionStartTime(Date extensionStartTime)
    {
     this.extensionStartTime=extensionStartTime;
    }
    
    @Column(name="ExtensionEndTime")
    public Date getExtensionEndTime()
    {
        return this.extensionEndTime;
    }
    public void setExtensionEndTime(Date extensionEndTime)
    {
     this.extensionEndTime=extensionEndTime;
    }
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderId", referencedColumnName="tenderId")
    public TblTender gettblTender()
    {
        return this.tblTender;
    }
    public void settblTender(TblTender tblTender)
    {
        this.tblTender=tblTender;
    }
}
