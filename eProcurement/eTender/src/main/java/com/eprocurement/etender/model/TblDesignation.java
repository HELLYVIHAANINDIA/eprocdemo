/*
 * Created on 18 Nov 2016 ( Time 04:40:49 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_designation"
 *
 *
 */

@Entity
@Table(name="tbl_designation")
// Define named queries here

public class TblDesignation implements Serializable {

    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    
    private Integer    designationId ;
    //----------------------------------------------------------------------
    // ENTITY DATA FIELDS 
    //----------------------------------------------------------------------    
    private String     designationName ;
    private Integer    createdBy    ;
    private Date       createDate   ;
    private Integer    modifiedBy   ;
    private Date       modifiedDate ;
    private Integer    deptId       ;
    


    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblDesignation() {
		super();
    }
    
    public TblDesignation(int designationId) {
    	this.designationId=designationId;
    }
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setDesignationId( Integer designationId ) {
        this.designationId = designationId ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="designationId", nullable=false)
    public Integer getDesignationId() {
        return this.designationId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : designationName ( VARCHAR ) 
    public void setDesignationName( String designationName ) {
        this.designationName = designationName;
    }
    @Column(name="designationName", nullable=false, length=50)
    public String getDesignationName() {
        return this.designationName;
    }

    //--- DATABASE MAPPING : createdBy ( INT ) 
    public void setCreatedBy( Integer createdBy ) {
        this.createdBy = createdBy;
    }
    @Column(name="createdBy", nullable=false)
    public Integer getCreatedBy() {
        return this.createdBy;
    }

    //--- DATABASE MAPPING : createDate ( DATETIME ) 
    public void setCreateDate( Date createDate ) {
        this.createDate = createDate;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createDate", nullable=false)
    public Date getCreateDate() {
        return this.createDate;
    }

    //--- DATABASE MAPPING : modifiedBy ( INT ) 
    public void setModifiedBy( Integer modifiedBy ) {
        this.modifiedBy = modifiedBy;
    }
    @Column(name="modifiedBy")
    public Integer getModifiedBy() {
        return this.modifiedBy;
    }

    //--- DATABASE MAPPING : modifiedDate ( DATETIME ) 
    public void setModifiedDate( Date modifiedDate ) {
        this.modifiedDate = modifiedDate;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="modifiedDate")
    public Date getModifiedDate() {
        return this.modifiedDate;
    }


    


    @Column(name="deptId", nullable=false)
    public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	private Set<TblOfficer> tblOfficer = new HashSet<TblOfficer>();
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblDesignation")          
	public Set<TblOfficer> getTblOfficer()
    {
        return tblOfficer;
    }
    public void setTblOfficer(Set<TblOfficer> tblOfficer)
    {
        this.tblOfficer = tblOfficer;
    }
	//----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(designationId);
        sb.append("]:"); 
        sb.append(designationName);
        sb.append("|");
        sb.append(createdBy);
        sb.append("|");
        sb.append(createDate);
        sb.append("|");
        sb.append(modifiedBy);
        sb.append("|");
        sb.append(modifiedDate);
        return sb.toString(); 
    } 

}
