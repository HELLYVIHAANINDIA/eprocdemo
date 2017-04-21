/*
 * Created on 17 Nov 2016 ( Time 01:57:57 )
 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_department"
 *
 *
 */

@Entity
@Table(name="tbl_department" )
// Define named queries here

public class TblDepartment implements Serializable {

    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="deptId", nullable=false)
    private Integer    deptId       ;


    //----------------------------------------------------------------------
    // ENTITY DATA FIELDS 
    //----------------------------------------------------------------------    
    @Column(name="deptName", nullable=false, length=250)
    private String     deptName     ;

    @Column(name="addressline1", length=500)
    private String     addressline1      ;

    @Column(name="countryId")
    private Integer    countryId    ;

    @Column(name="stateId")
    private Integer    stateId      ;

    @Column(name="city", length=100)
    private String     city         ;

    @Column(name="phoneNo")
    private String     phoneno      ;

    @Column(name="parentDeptId")
    private Integer    parentDeptId ;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdOn")
    private Date       createdOn    ;

    @Column(name="createdBy")
    private Integer    createdBy    ;

    @Column(name="grandParentDeptId",nullable=false)
    private Integer    grandParentDeptId    ;
    
    @Column(name="mailHostName")
    private String    mailHostName    ;
    
    @Column(name="mailPort")
    private String    mailPort    ;
    
    @Column(name="fromMailId")
    private String    fromMailId    ;
    
    @Column(name="mailUsername")
    private String    mailUsername    ;
    
    @Column(name="mailPassword")
    private String    mailPassword    ;
    
    @Column(name="cstatus")
    private Integer    cstatus    ;
    
    @Column(name="deptDocId")
    private Integer    deptDocId;
    

    @Column(name="remarks")
    private String    remarks;
    
    @Column(name="website")
    private String    website;
    
    @Column(name="mobileNo")
    private String    mobileNo;
    
    @Column(name="addressline2")
    private String addressline2;
    
    @Column(name="originCountryId")
    private Integer originCountryId;
    
    @Column(name="commercialRegNo")
    private String commercialRegNo;
    
    @Column(name="establishDate")
    private Date establishDate;
    
    @Column(name="postalAddressLine1")
    private String postalAddressLine1;
    
    @Column(name="postalAddressLine2")
    private String postalAddressLine2;
    
    @Column(name="postalStateId")
    private Integer postalStateId;
    
    @Column(name="postalCity")
    private String postalCity;
    
    @Column(name="designationName")
    private String designationName;
    
    @Column(name="personalMobileNo")
    private String personalMobileNo;
    
    @Column(name="personalPhoneNo")
    private String personalPhoneNo;
    
    @Column(name="registerType")
    private String registerType;
    
    @Column(name="emailId")
    private String     emailId      ;
    
    @Column(name="personName")
    private String     personName   ;

    @Column(name="timezoneId")
    private int timezoneId;
    
    @Column(name="isEmailVerified")
    private int isEmailVerified=0;
    
    @Column(name="tenderAuthorityFirstTimePassword")
    private String     tenderAuthorityFirstTimePassword ;
    
    
    
    //----------------------------------------------------------------------
    // ENTITY LINKS ( RELATIONSHIP )
    //----------------------------------------------------------------------

    
   
    
    public String getMailHostName() {
		return mailHostName;
	}

	public String getTenderAuthorityFirstTimePassword() {
		return tenderAuthorityFirstTimePassword;
	}

	public void setTenderAuthorityFirstTimePassword(String tenderAuthorityFirstTimePassword) {
		this.tenderAuthorityFirstTimePassword = tenderAuthorityFirstTimePassword;
	}

	public String getAddressline1() {
		return addressline1;
	}

	public void setAddressline1(String addressline1) {
		this.addressline1 = addressline1;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	
	public int getTimezoneId() {
		return timezoneId;
	}

	public void setTimezoneId(int timezoneId) {
		this.timezoneId = timezoneId;
	}

	public String getMailUsername() {
		return mailUsername;
	}

	public void setMailUsername(String mailUsername) {
		this.mailUsername = mailUsername;
	}

	public String getMailPassword() {
		return mailPassword;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}

	public void setMailHostName(String mailHostName) {
		this.mailHostName = mailHostName;
	}

	public String getMailPort() {
		return mailPort;
	}

	public void setMailPort(String mailPort) {
		this.mailPort = mailPort;
	}

	public String getFromMailId() {
		return fromMailId;
	}

	public void setFromMailId(String fromMailId) {
		this.fromMailId = fromMailId;
	}
	
	public Integer getCstatus() {
		return cstatus;
	}

	public void setCstatus(Integer cstatus) {
		this.cstatus = cstatus;
	}
	
	
	
	
	public int getIsEmailVerified() {
		return isEmailVerified;
	}

	public void setIsEmailVerified(int isEmailVerified) {
		this.isEmailVerified = isEmailVerified;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public Integer getDeptDocId() {
		return deptDocId;
	}

	public void setDeptDocId(Integer deptDocId) {
		this.deptDocId = deptDocId;
	}

	//----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblDepartment() {
		super();
    }
    
    public TblDepartment(int deptId) {
		this.deptId=deptId;
    }
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setDeptId( Integer deptId ) {
        this.deptId = deptId ;
    }
    
	public Integer getDeptId() {
        return this.deptId;
    }
	
	
    public Integer getGrandParentDeptId() {
		return grandParentDeptId;
	}

	public void setGrandParentDeptId(Integer grandParentDeptId) {
		this.grandParentDeptId = grandParentDeptId;
	}

	//----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : deptName ( VARCHAR ) 
    public void setDeptName( String deptName ) {
        this.deptName = deptName;
    }
    public String getDeptName() {
        return this.deptName;
    }

    //--- DATABASE MAPPING : address ( VARCHAR ) 
    public void setAddress( String addressline1 ) {
        this.addressline1 = addressline1;
    }
    public String getAddress() {
        return this.addressline1;
    }

    //--- DATABASE MAPPING : countryId ( INT ) 
    public void setCountryId( Integer countryId ) {
        this.countryId = countryId;
    }
    public Integer getCountryId() {
        return this.countryId;
    }

    //--- DATABASE MAPPING : stateId ( INT ) 
    public void setStateId( Integer stateId ) {
        this.stateId = stateId;
    }
    public Integer getStateId() {
        return this.stateId;
    }

    //--- DATABASE MAPPING : city ( VARCHAR ) 
    public void setCity( String city ) {
        this.city = city;
    }
    public String getCity() {
        return this.city;
    }
    
    public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	//--- DATABASE MAPPING : phoneNo ( VARCHAR ) 
    public void setPhoneno( String phoneno ) {
        this.phoneno = phoneno;
    }
    public String getPhoneno() {
        return this.phoneno;
    }

    //--- DATABASE MAPPING : parentDeptId ( INT ) 
    public void setParentDeptId( Integer parentDeptId ) {
        this.parentDeptId = parentDeptId;
    }
    public Integer getParentDeptId() {
        return this.parentDeptId;
    }

    //--- DATABASE MAPPING : createdOn ( DATETIME ) 
    public void setCreatedOn( Date createdOn ) {
        this.createdOn = createdOn;
    }
    public Date getCreatedOn() {
        return this.createdOn;
    }

    //--- DATABASE MAPPING : createdBy ( INT ) 
    public void setCreatedBy( Integer createdBy ) {
        this.createdBy = createdBy;
    }
    public Integer getCreatedBy() {
        return this.createdBy;
    }

    @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblDepartment")
    private Set<TblOfficer> tblOfficer = new HashSet<TblOfficer>();
	          
	public Set<TblOfficer> getTblOfficer()
    {
        return tblOfficer;
    }
    public void setTblOfficer(Set<TblOfficer> tblOfficer)
    {
        this.tblOfficer = tblOfficer;
    }

    
    
	public String getAddressline2() {
		return addressline2;
	}

	public void setAddressline2(String addressline2) {
		this.addressline2 = addressline2;
	}

	
	public Integer getOriginCountryId() {
		return originCountryId;
	}

	public void setOriginCountryId(Integer originCountryId) {
		this.originCountryId = originCountryId;
	}

	
	public String getCommercialRegNo() {
		return commercialRegNo;
	}

	public void setCommercialRegNo(String commercialRegNo) {
		this.commercialRegNo = commercialRegNo;
	}

	
	public Date getEstablishDate() {
		return establishDate;
	}

	public void setEstablishDate(Date establishDate) {
		this.establishDate = establishDate;
	}

	
	public String getPostalAddressLine1() {
		return postalAddressLine1;
	}

	public void setPostalAddressLine1(String postalAddressLine1) {
		this.postalAddressLine1 = postalAddressLine1;
	}

	
	public String getPostalAddressLine2() {
		return postalAddressLine2;
	}

	public void setPostalAddressLine2(String postalAddressLine2) {
		this.postalAddressLine2 = postalAddressLine2;
	}

	
	public Integer getPostalStateId() {
		return postalStateId;
	}

	public void setPostalStateId(Integer postalStateId) {
		this.postalStateId = postalStateId;
	}

	
	public String getPostalCity() {
		return postalCity;
	}

	public void setPostalCity(String postalCity) {
		this.postalCity = postalCity;
	}

	@Column(name="designationName")
	public String getDesignationName() {
		return designationName;
	}

	public void setDesignationName(String designationName) {
		this.designationName = designationName;
	}

	
	public String getPersonalMobileNo() {
		return personalMobileNo;
	}

	public void setPersonalMobileNo(String personalMobileNo) {
		this.personalMobileNo = personalMobileNo;
	}

	
	public String getPersonalPhoneNo() {
		return personalPhoneNo;
	}

	public void setPersonalPhoneNo(String personalPhoneNo) {
		this.personalPhoneNo = personalPhoneNo;
	}

	
	public String getRegisterType() {
		return registerType;
	}

	public void setRegisterType(String registerType) {
		this.registerType = registerType;
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
        sb.append(deptId);
        sb.append("]:"); 
        sb.append(deptName);
        sb.append("|");
        sb.append(addressline1);
        sb.append("|");
        sb.append(countryId);
        sb.append("|");
        sb.append(stateId);
        sb.append("|");
        sb.append(city);
        sb.append("|");
        sb.append(phoneno);
        sb.append("|");
        sb.append(parentDeptId);
        sb.append("|");
        sb.append(createdOn);
        sb.append("|");
        sb.append(createdBy);
        return sb.toString(); 
    } 

}
