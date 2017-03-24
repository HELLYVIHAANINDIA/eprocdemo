/*
 * Created on 8 Nov 2016 ( Time 18:03:01 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;
//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;
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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Persistent class for entity stored in table "tbl_officer"
 *
 *
 */

@Entity
@Table(name="tbl_officer")
// Define named queries here

public class TblOfficer implements Serializable {

    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    
    private Long       id           ;
    private String     address      ;
    private String     officername  ;
    private String     city         ;
    private String     companyname  ;
    private Integer    countryid    ;
    private Integer    createdby    ;
    private Date       datecreated  ;
    private Date       datemodified ;
    private String     emailid      ;
    private String    mobileno     ;
    private Integer    modifiedby   ;
    private Integer    stateid      ;
    private Integer    cstatus       ;
    private TblDesignation tblDesignation;
    private TblDepartment    tblDepartment ;
    private String     phoneNo      ;
    private TblUserLogin tblUserlogin;
    

	// "userid" (column "userid") is not defined by itself because used as FK in a link 
    
    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblOfficer(long id) {
    	this.id = id ;
    }
    
    public TblOfficer() {
    	
    }



	@Column(name="phoneNo")
	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}



	//----------------------------------------------------------------------
    // ENTITY LINKS ( RELATIONSHIP )
    //----------------------------------------------------------------------
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setId( Long id ) {
        this.id = id ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="id", nullable=false)
    public Long getId() {
        return this.id;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : address ( LONGTEXT ) 
    public void setAddress( String address ) {
        this.address = address;
    }
    @Column(name="address")
    public String getAddress() {
        return this.address;
    }

    //--- DATABASE MAPPING : officername ( VARCHAR ) 
    public void setOfficername( String officername ) {
        this.officername = officername;
    }
    @Column(name="officername", nullable=false, length=250)
    public String getOfficername() {
        return this.officername;
    }

    //--- DATABASE MAPPING : city ( LONGTEXT ) 
    public void setCity( String city ) {
        this.city = city;
    }
    @Column(name="city")
    public String getCity() {
        return this.city;
    }

    //--- DATABASE MAPPING : companyname ( VARCHAR ) 
    public void setCompanyname( String companyname ) {
        this.companyname = companyname;
    }
    @Column(name="companyname", length=250)
    public String getCompanyname() {
        return this.companyname;
    }

    //--- DATABASE MAPPING : countryid ( INT ) 
    public void setCountryid( Integer countryid ) {
        this.countryid = countryid;
    }
    @Column(name="countryid")
    public Integer getCountryid() {
        return this.countryid;
    }

    //--- DATABASE MAPPING : createdby ( INT ) 
    public void setCreatedby( Integer createdby ) {
        this.createdby = createdby;
    }
    @Column(name="createdby", nullable=false)
    public Integer getCreatedby() {
        return this.createdby;
    }

    //--- DATABASE MAPPING : datecreated ( DATETIME ) 
    public void setDatecreated( Date datecreated ) {
        this.datecreated = datecreated;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="datecreated", nullable=false)
    public Date getDatecreated() {
        return this.datecreated;
    }

    //--- DATABASE MAPPING : datemodified ( DATETIME ) 
    public void setDatemodified( Date datemodified ) {
        this.datemodified = datemodified;
    }
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="datemodified")
    public Date getDatemodified() {
        return this.datemodified;
    }

    //--- DATABASE MAPPING : emailid ( VARCHAR ) 
    public void setEmailid( String emailid ) {
        this.emailid = emailid;
    }
    @Column(name="emailid", nullable=false, length=250)
    public String getEmailid() {
        return this.emailid;
    }

    

    @Column(name="mobileno")
    public String getMobileno() {
		return mobileno;
	}

	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}

	@Column(name="cstatus", nullable=false)	
	public Integer getCstatus() {
		return cstatus;
	}

	public void setCstatus(Integer cstatus) {
		this.cstatus = cstatus;
	}

	//--- DATABASE MAPPING : modifiedby ( INT ) 
    public void setModifiedby( Integer modifiedby ) {
        this.modifiedby = modifiedby;
    }
    @Column(name="modifiedby")
    public Integer getModifiedby() {
        return this.modifiedby;
    }

    //--- DATABASE MAPPING : stateid ( INT ) 
    public void setStateid( Integer stateid ) {
        this.stateid = stateid;
    }
    @Column(name="stateid")
    public Integer getStateid() {
        return this.stateid;
    }

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="designationId")
    public TblDesignation getTblDesignation() {
		return tblDesignation;
	}

	public void setTblDesignation(TblDesignation tblDesignation) {
		this.tblDesignation = tblDesignation;
	}

	//----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------
	
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="userId")
    public TblUserLogin getTblUserlogin() {
        return this.tblUserlogin;
    }
    public void setTblUserlogin( TblUserLogin tblUserlogin ) {
        this.tblUserlogin = tblUserlogin;
    }
    
	@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="deptId")
    public TblDepartment getTblDepartment() {
        return this.tblDepartment;
    }
    public void setTblDepartment( TblDepartment tblDepartment ) {
        this.tblDepartment = tblDepartment;
    }
    			
    private Set<TblCommitteeUser> tblCommitteeUser = new HashSet<TblCommitteeUser>();
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblOfficer")          
	public Set<TblCommitteeUser> getTblCommitteeUser()
    {
        return tblCommitteeUser;
    }
    public void setTblCommitteeUser(Set<TblCommitteeUser> tblCommitteeUser)
    {
        this.tblCommitteeUser = tblCommitteeUser;
    }
    

    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(id);
        sb.append("]:"); 
        // attribute 'address' not usable (type = String Long Text)
        sb.append(officername);
        // attribute 'city' not usable (type = String Long Text)
        sb.append("|");
        sb.append(companyname);
        sb.append("|");
        sb.append(countryid);
        sb.append("|");
        sb.append(createdby);
        sb.append("|");
        sb.append(datecreated);
        sb.append("|");
        sb.append(datemodified);
        sb.append("|");
        sb.append(emailid);
        sb.append("|");
        sb.append(mobileno);
        sb.append("|");
        sb.append(modifiedby);
        sb.append("|");
        sb.append(stateid);
        sb.append("|");
        sb.append(cstatus);
        return sb.toString(); 
    } 

}
