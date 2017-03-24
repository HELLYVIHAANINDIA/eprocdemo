/*
 * Created on 6 Dec 2016 ( Time 07:19:38 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;

import java.util.Date;

import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_officerdocument"
 *
 *
 */

@Entity
@Table(name="tbl_officerdocument" )
public class TblOfficerdocument implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer    officerDocId ;
    private String     fileName     ;
    private String     description  ;
    private String     path         ;
    private String     fileType     ;
    private Integer    fileSize     ;
    private Integer    tenderId     ;
    private Integer    objectId     ;
    private Integer    childId      ;
    private Integer    subChildId   ;
    private Integer    otherSubChildId;
    private Integer    officerId    ;
    private Date       createdOn    ;
    private Integer    cstatus      ;



    //----------------------------------------------------------------------
    // ENTITY LINKS ( RELATIONSHIP )
    //----------------------------------------------------------------------

    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblOfficerdocument() {
		super();
    }
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setOfficerDocId( Integer officerDocId ) {
        this.officerDocId = officerDocId ;
    }
    
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="officerDocId", nullable=false)
    public Integer getOfficerDocId() {
        return this.officerDocId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : fileName ( VARCHAR ) 
    public void setFileName( String fileName ) {
        this.fileName = fileName;
    }
    @Column(name="fileName", nullable=false, length=250)
    public String getFileName() {
        return this.fileName;
    }

    //--- DATABASE MAPPING : description ( VARBINARY ) 
    public void setDescription( String description ) {
        this.description = description;
    }
    @Column(name="description")
    public String getDescription() {
        return this.description;
    }

    //--- DATABASE MAPPING : path ( VARCHAR ) 
    public void setPath( String path ) {
        this.path = path;
    }
    @Column(name="path", nullable=false, length=100)
    public String getPath() {
        return this.path;
    }

    //--- DATABASE MAPPING : fileType ( VARCHAR ) 
    public void setFileType( String fileType ) {
        this.fileType = fileType;
    }
    @Column(name="fileType", nullable=false, length=250)
    public String getFileType() {
        return this.fileType;
    }

    //--- DATABASE MAPPING : fileSize ( INT ) 
    public void setFileSize( Integer fileSize ) {
        this.fileSize = fileSize;
    }
    @Column(name="fileSize", nullable=false)
    public Integer getFileSize() {
        return this.fileSize;
    }

    //--- DATABASE MAPPING : tenderId ( INT ) 
    public void setTenderId( Integer tenderId ) {
        this.tenderId = tenderId;
    }
    @Column(name="tenderId", nullable=false)
    public Integer getTenderId() {
        return this.tenderId;
    }

    //--- DATABASE MAPPING : objectId ( INT ) 
    public void setObjectId( Integer objectId ) {
        this.objectId = objectId;
    }
    @Column(name="objectId")
    public Integer getObjectId() {
        return this.objectId;
    }

    //--- DATABASE MAPPING : childId ( INT ) 
    public void setChildId( Integer childId ) {
        this.childId = childId;
    }
    @Column(name="childId")
    public Integer getChildId() {
        return this.childId;
    }

    //--- DATABASE MAPPING : subChildId ( INT ) 
    public void setSubChildId( Integer subChildId ) {
        this.subChildId = subChildId;
    }
    
    @Column(name="otherSubChildId")
    public Integer getOtherSubChildId() {
		return otherSubChildId;
	}

	public void setOtherSubChildId(Integer otherSubChildId) {
		this.otherSubChildId = otherSubChildId;
	}

	@Column(name="subChildId")
    public Integer getSubChildId() {
        return this.subChildId;
    }

    //--- DATABASE MAPPING : officerId ( INT ) 
    public void setOfficerId( Integer officerId ) {
        this.officerId = officerId;
    }
    @Column(name="officerId", nullable=false)
    public Integer getOfficerId() {
        return this.officerId;
    }

    //--- DATABASE MAPPING : createdOn ( DATETIME ) 
    public void setCreatedOn( Date createdOn ) {
        this.createdOn = createdOn;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdOn", nullable=false)
    public Date getCreatedOn() {
        return this.createdOn;
    }

    //--- DATABASE MAPPING : cstatus ( INT ) 
    public void setCstatus( Integer cstatus ) {
        this.cstatus = cstatus;
    }
    @Column(name="cstatus", nullable=false)
    public Integer getCstatus() {
        return this.cstatus;
    }


    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------

    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(officerDocId);
        sb.append("]:"); 
        sb.append(fileName);
        // attribute 'description' not usable (type = byte[])
        sb.append("|");
        sb.append(path);
        sb.append("|");
        sb.append(fileType);
        sb.append("|");
        sb.append(fileSize);
        sb.append("|");
        sb.append(tenderId);
        sb.append("|");
        sb.append(objectId);
        sb.append("|");
        sb.append(childId);
        sb.append("|");
        sb.append(subChildId);
        sb.append("|");
        sb.append(officerId);
        sb.append("|");
        sb.append(createdOn);
        sb.append("|");
        sb.append(cstatus);
        return sb.toString(); 
    } 

}
