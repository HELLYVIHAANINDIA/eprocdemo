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

import com.eprocurement.common.model.TblProcess;

@Entity
@Table(name="tbl_corrigendumdetail")
public class TblCorrigendumDetail  implements java.io.Serializable {

        private   int actionType;
        private   int corrigendumDetailId;
        private   int createdBy;
        private   Date createdOn = new Date();
        private   String fieldLabel;
        private   String fieldName;
        private   String newValue;
        private   int objectId;
        private   String oldValue;
        private   TblCorrigendum tblCorrigendum;
        private   TblProcess tblProcess;


        @Column(name="actionType",nullable=false)
        public int getActionType() {
            return this.actionType;
        }

        public void setActionType(int actionType) {
            this.actionType = actionType;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="corrigendumDetailId",unique=true,nullable=false)
        public int getCorrigendumDetailId() {
            return this.corrigendumDetailId;
        }

        public void setCorrigendumDetailId(int corrigendumDetailId) {
            this.corrigendumDetailId = corrigendumDetailId;
        }
        public TblCorrigendumDetail(int corrigendumDetailId){
            this.corrigendumDetailId = corrigendumDetailId;
        }
        @Column(name="createdBy",nullable=false)
        public int getCreatedBy() {
            return this.createdBy;
        }

        public void setCreatedBy(int createdBy) {
            this.createdBy = createdBy;
        }
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="createdOn")
        public Date getCreatedOn() {
            return this.createdOn;
        }

        public void setCreatedOn(Date createdOn) {
            this.createdOn = createdOn;
        }
        @Column(name="fieldLabel",nullable=false, length=200)
        public String getFieldLabel() {
            return this.fieldLabel;
        }

        public void setFieldLabel(String fieldLabel) {
            this.fieldLabel = fieldLabel;
        }
        @Column(name="fieldName",nullable=false, length= 100)
        public String getFieldName() {
            return this.fieldName;
        }

        public void setFieldName(String fieldName) {
            this.fieldName = fieldName;
        }
        @Column(name="newValue",nullable=false, length=100)
        public String getNewValue() {
            return this.newValue;
        }

        public void setNewValue(String newValue) {
            this.newValue = newValue;
        }
        @Column(name="objectId",nullable=false)
        public int getObjectId() {
            return this.objectId;
        }

        public void setObjectId(int objectId) {
            this.objectId = objectId;
        }
        @Column(name="oldValue",nullable=false, length=100)
        public String getOldValue() {
            return this.oldValue;
        }

        public void setOldValue(String oldValue) {
            this.oldValue = oldValue;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="corrigendumid")
        public TblCorrigendum getTblCorrigendum() {
            return this.tblCorrigendum;
        }

        public void setTblCorrigendum(TblCorrigendum tblCorrigendum) {
            this.tblCorrigendum = tblCorrigendum;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="processid")
        public TblProcess getTblProcess() {
            return this.tblProcess;
        }

        public void setTblProcess(TblProcess tblProcess) {
            this.tblProcess = tblProcess;
        }
        public TblCorrigendumDetail(){
        }
        @Override
	public String toString() {
		return new ToStringCreator(this)
.append("actionType", this.getActionType())
.append("corrigendumDetailId", this.getCorrigendumDetailId())
.append("createdBy", this.getCreatedBy())
.append("createdOn", this.getCreatedOn())
.append("fieldLabel", this.getFieldLabel())
.append("fieldName", this.getFieldName())
.append("newValue", this.getNewValue())
.append("objectId", this.getObjectId())
.append("oldValue", this.getOldValue())


		.toString();

	}
}
