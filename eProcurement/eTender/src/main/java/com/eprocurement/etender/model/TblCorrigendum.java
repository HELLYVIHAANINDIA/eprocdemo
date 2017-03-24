package com.eprocurement.etender.model;

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

import com.eprocurement.common.model.TblProcess;

@Entity
@Table(name = "tbl_corrigendum")
public class TblCorrigendum implements java.io.Serializable {

    private int corrigendumId;
    private String corrigendumText;
    private int createdBy;
    private Date createdOn;
    private int cstatus;
    private int objectId;
    private int publishedBy;
    private Date publishedOn = new Date();
    private String remarks;
    private TblProcess tblProcess;
    private Set<TblCorrigendumDetail> tblCorrigendumDetail = new HashSet<TblCorrigendumDetail>();

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tblCorrigendum")
    public Set<TblCorrigendumDetail> getTblCorrigendumDetail() {
        return tblCorrigendumDetail;
    }

    public void setTblCorrigendumDetail(Set<TblCorrigendumDetail> tblCorrigendumDetail) {
        this.tblCorrigendumDetail = tblCorrigendumDetail;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "corrigendumId", unique = true, nullable = false)
    public int getCorrigendumId() {
        return this.corrigendumId;
    }

    public void setCorrigendumId(int corrigendumId) {
        this.corrigendumId = corrigendumId;
    }

    public TblCorrigendum(int corrigendumId) {
        this.corrigendumId = corrigendumId;
    }

    @Column(name = "corrigendumText", length = 5000)
    public String getCorrigendumText() {
        return this.corrigendumText;
    }

    public void setCorrigendumText(String corrigendumText) {
        this.corrigendumText = corrigendumText;
    }

    @Column(name = "createdBy")
    public int getCreatedBy() {
        return this.createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    @Column(name = "createdOn")
    public Date getCreatedOn() {
        return this.createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Column(name = "cstatus")
    public int getCstatus() {
        return cstatus;
    }

    public void setCstatus(int cstatus) {
        this.cstatus = cstatus;
    }

    @Column(name = "objectId", nullable = false)
    public int getObjectId() {
        return this.objectId;
    }

    public void setObjectId(int objectId) {
        this.objectId = objectId;
    }

    @Column(name = "publishedBy")
    public int getPublishedBy() {
        return this.publishedBy;
    }

    public void setPublishedBy(int publishedBy) {
        this.publishedBy = publishedBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "publishedOn")
    public Date getPublishedOn() {
        return this.publishedOn;
    }

    public void setPublishedOn(Date publishedOn) {
        this.publishedOn = publishedOn;
    }

    @Column(name = "remarks", length = 1000)
    public String getRemarks() {
        return this.remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "processid")
    public TblProcess getTblProcess() {
        return this.tblProcess;
    }

    public void setTblProcess(TblProcess tblProcess) {
        this.tblProcess = tblProcess;
    }

    public TblCorrigendum() {
    }

    @Override
    public String toString() {
        return new ToStringCreator(this)
                .append("corrigendumId", this.getCorrigendumId())
                .append("corrigendumText", this.getCorrigendumText())
                .append("createdBy", this.getCreatedBy())
                .append("createdOn", this.getCreatedOn())
                .append("cstatus", this.getCstatus())
                .append("objectId", this.getObjectId())
                .append("publishedBy", this.getPublishedBy())
                .append("publishedOn", this.getPublishedOn())
                .append("remarks", this.getRemarks())
                .toString();

    }
}
