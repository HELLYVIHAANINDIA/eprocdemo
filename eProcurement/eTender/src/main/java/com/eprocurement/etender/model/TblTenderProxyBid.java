/*
 * To change this template, choose Tools | Templates
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "tbl_tenderproxybid")
public class TblTenderProxyBid implements java.io.Serializable {

    private String cellValue;
    private int createdBy;
    private Date createdOn;
    private String ipAddress;
    private int proxyBidId;
    private int rowId;
    private   int isUpdatedFrom;
    private TblTender tblTender;
    private TblTenderCell tblTenderCell;
    private TblTenderColumn tblTenderColumn;
    private TblTenderTable tblTenderTable;
    private   TblCompany tblCompany;

    @Column(name = "cellValue", nullable = false, length = 0)
    public String getCellValue() {
        return this.cellValue;
    }

    public void setCellValue(String cellValue) {
        this.cellValue = cellValue;
    }

    @Column(name = "createdBy", nullable = false)
    public int getCreatedBy() {
        return this.createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createdOn", nullable = false, updatable = false, insertable = false)
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
    @Column(name = "proxyBidId", unique = true, nullable = false)
    public int getProxyBidId() {
        return this.proxyBidId;
    }

    public void setProxyBidId(int proxyBidId) {
        this.proxyBidId = proxyBidId;
    }

    public TblTenderProxyBid(int proxyBidId) {
        this.proxyBidId = proxyBidId;
    }

    @Column(name = "rowId", nullable = false)
    public int getRowId() {
        return this.rowId;
    }

    public void setRowId(int rowId) {
        this.rowId = rowId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenderId")
    public TblTender getTblTender() {
        return this.tblTender;
    }

    public void setTblTender(TblTender tblTender) {
        this.tblTender = tblTender;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "celliId")
    public TblTenderCell getTblTenderCell() {
        return this.tblTenderCell;
    }

    public void setTblTenderCell(TblTenderCell tblTenderCell) {
        this.tblTenderCell = tblTenderCell;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "columnId")
    public TblTenderColumn getTblTenderColumn() {
        return this.tblTenderColumn;
    }

    public void setTblTenderColumn(TblTenderColumn tblTenderColumn) {
        this.tblTenderColumn = tblTenderColumn;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tableId")
    public TblTenderTable getTblTenderTable() {
        return this.tblTenderTable;
    }

    public void setTblTenderTable(TblTenderTable tblTenderTable) {
        this.tblTenderTable = tblTenderTable;
    }

   @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="companyId")
    public TblCompany getTblCompany() {
        return this.tblCompany;
    }

    public void setTblCompany(TblCompany tblCompany) {
        this.tblCompany = tblCompany;
    }

    @Column(name="isUpdatedFrom",nullable=false)
    public int getIsUpdatedFrom() {
        return this.isUpdatedFrom;
    }

    public void setIsUpdatedFrom(int isUpdatedFrom) {
        this.isUpdatedFrom = isUpdatedFrom;
    }
    
    public TblTenderProxyBid() {
    }

    @Override
    public String toString() {
        return new ToStringCreator(this)
                .append("cellValue", this.getCellValue())
                .append("createdBy", this.getCreatedBy())
                .append("createdOn", this.getCreatedOn())
                .append("ipAddress", this.getIpAddress())
                .append("proxyBidId", this.getProxyBidId())
                .append("isUpdatedFrom", this.getIsUpdatedFrom())
                .append("rowId", this.getRowId())
                .toString();

    }
}
