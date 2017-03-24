/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author BigGoal
 */
@Entity
@Table(name="tbl_tenderdocument")
public class TblTenderDocument implements java.io.Serializable {
        private int documentId;
        private int isMandatory;
        private String documentName;
        private TblTender tblTender;
        private TblTenderForm tblTenderForm;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="documentId",nullable=false)
    public int getDocumentId() {
        return this.documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    @Column(name="isMandatory")
    public int getIsMandatory(){
        return this.isMandatory;
    }
    
    public void setIsMandatory(int isMandatory)
    {
        this.isMandatory=isMandatory;
    }
    
    @Column(name="documentName")
    public String getDocumentName(){
        return this.documentName;
    }
    
    public void setDocumentName(String documentName)
    {
        this.documentName=documentName;
    }
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderId")
    public TblTender getTblTender(){
        return this.tblTender;
    }
    
    public void setTblTender(TblTender tblTender){
        this.tblTender=tblTender;
    }
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="formId")
    public TblTenderForm getTblTenderForm(){
        return this.tblTenderForm;
    }
    
    public void setTblTenderForm(TblTenderForm tblTenderForm){
        this.tblTenderForm=tblTenderForm;
    }
}
