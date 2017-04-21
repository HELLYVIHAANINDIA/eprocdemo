/*
 * Created on 26 Nov 2016 ( Time 05:37:35 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;
import java.util.Date;




//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;
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

/**
 * Persistent class for entity stored in table "tbl_bidder"
 *
 *
 */

@Entity
@Table(name="tbl_bidder")
// Define named queries here

public class TblBidder implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer    bidderId     ;
    private String     emailId      ;
    private String     personName   ;
    private String     lastName   ;
    private String     middleName   ;
    private String     companyName  ;
    private String     addressline1      ;
    private String     city         ;
    private String     phoneno      ;
    private String     mobileno     ;
    private String     website      ;
    private TblState tblState    ;
    private TblCountry tblCountry  ;
    private String keyword;
    private int cstatus;
    private TblUserLogin tblUserlogin;
    private Integer    createdby    ;
    private Date       datecreated  ;
    private Date       datemodified ;
    private Integer    modifiedby   ;
    private TblCompany tblCompany; 
    private String remarks;
    private int timezoneId;
    private int bidderDocId;
    
    private String addressline2;
    private Integer originCountryId;
    private String commercialRegNo;
    private Date establishDate;
    private String postalAddressLine1;
    private String postalAddressLine2;
    private Integer postalStateId;
    private String postalCity;
    private String designationName;
    private String personalMobileNo;
    private String personalPhoneNo;
    private String registerType;
    private int isEmailVerified=0;

    


    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblBidder() {
		super();
    }
    
    public TblBidder(int bidderId) {
		this.bidderId=bidderId;
    }
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="companyid")
	public TblCompany getTblCompany() {
		return tblCompany;
	}

	public void setTblCompany(TblCompany tblCompany) {
		this.tblCompany = tblCompany;
	}

	//----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setBidderId( Integer bidderId ) {
        this.bidderId = bidderId ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="bidderId", nullable=false)
    public Integer getBidderId() {
        return this.bidderId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : emailId ( VARCHAR ) 
    public void setEmailId( String emailId ) {
        this.emailId = emailId;
    }
    @Column(name="emailId", nullable=false, length=100)
    public String getEmailId() {
        return this.emailId;
    }

    //--- DATABASE MAPPING : personName ( VARCHAR ) 
    public void setPersonName( String personName ) {
        this.personName = personName;
    }
    @Column(name="personName", nullable=false, length=25)
    public String getPersonName() {
        return this.personName;
    }
    
    @Column(name="isEmailVerified")
    public int getIsEmailVerified() {
		return isEmailVerified;
	}

	public void setIsEmailVerified(int isEmailVerified) {
		this.isEmailVerified = isEmailVerified;
	}

	@Column(name="lastName", length=25)
    public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@Column(name="middleName", length=25)
	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	//--- DATABASE MAPPING : companyName ( VARCHAR ) 
    public void setCompanyName( String companyName ) {
        this.companyName = companyName;
    }
    @Column(name="companyName", nullable=false, length=25)
    public String getCompanyName() {
        return this.companyName;
    }

    //--- DATABASE MAPPING : address ( VARCHAR ) 
    public void setAddress( String addressline1 ) {
        this.addressline1 = addressline1;
    }
    @Column(name="addressline1", nullable=false, length=250)
    public String getAddress() {
        return this.addressline1;
    }

    //--- DATABASE MAPPING : city ( VARCHAR ) 
    public void setCity( String city ) {
        this.city = city;
    }
    @Column(name="city", length=25)
    public String getCity() {
        return this.city;
    }

    //--- DATABASE MAPPING : phoneNo ( VARCHAR ) 
    public void setPhoneno( String phoneno ) {
        this.phoneno = phoneno;
    }
    @Column(name="phoneNo")
    public String getPhoneno() {
        return this.phoneno;
    }

    //--- DATABASE MAPPING : mobileNo ( VARCHAR ) 
    public void setMobileno( String mobileno ) {
        this.mobileno = mobileno;
    }
    @Column(name="mobileNo")
    public String getMobileno() {
        return this.mobileno;
    }

    //--- DATABASE MAPPING : website ( VARCHAR ) 
    public void setWebsite( String website ) {
        this.website = website;
    }
    @Column(name="website", length=25)
    public String getWebsite() {
        return this.website;
    }
    
    @Column(name="remarks")
    public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	//----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------
    public void setTblState( TblState tblState ) {
        this.tblState = tblState;
    }
    @ManyToOne
    @JoinColumn(name="stateId")
    public TblState getTblState() {
        return this.tblState;
    }

    public void setTblCountry( TblCountry tblCountry ) {
        this.tblCountry = tblCountry;
    }
    @ManyToOne
    @JoinColumn(name="countryId", referencedColumnName="countryId")
    public TblCountry  getTblCountry() {
        return this.tblCountry;
    }

    @Column(name="keyword", length=2000)
    public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Column(name="cstatus", nullable=false)
	public int getCstatus() {
		return cstatus;
	}

	public void setCstatus(int cstatus) {
		this.cstatus = cstatus;
	}

	
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="userId")
    public TblUserLogin getTblUserlogin() {
        return this.tblUserlogin;
    }
    public void setTblUserlogin( TblUserLogin tblUserlogin ) {
        this.tblUserlogin = tblUserlogin;
    }
    
    //--- DATABASE MAPPING : createdby ( INT ) 
    public void setCreatedby( Integer createdby ) {
        this.createdby = createdby;
    }
    @Column(name="createdBy", nullable=false)
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
    
    public void setModifiedby( Integer modifiedby ) {
        this.modifiedby = modifiedby;
    }
    @Column(name="modifiedBy")
    public Integer getModifiedby() {
        return this.modifiedby;
    }
    
    
    @Column(name="timezoneId")
    public int getTimezoneId() {
		return timezoneId;
	}

	public void setTimezoneId(int timezoneId) {
		this.timezoneId = timezoneId;
	}
	
    @Column(name="bidderDocId")
    public int getBidderDocId() {
		return bidderDocId;
	}

	public void setBidderDocId(int bidderDocId) {
		this.bidderDocId = bidderDocId;
	}
	
	@Column(name="addressline2")
	public String getAddressline2() {
		return addressline2;
	}

	public void setAddressline2(String addressline2) {
		this.addressline2 = addressline2;
	}

	@Column(name="originCountryId")
	public Integer getOriginCountryId() {
		return originCountryId;
	}

	public void setOriginCountryId(Integer originCountryId) {
		this.originCountryId = originCountryId;
	}

	@Column(name="commercialRegNo")
	public String getCommercialRegNo() {
		return commercialRegNo;
	}

	public void setCommercialRegNo(String commercialRegNo) {
		this.commercialRegNo = commercialRegNo;
	}

	@Column(name="establishDate")
	public Date getEstablishDate() {
		return establishDate;
	}

	public void setEstablishDate(Date establishDate) {
		this.establishDate = establishDate;
	}

	@Column(name="postalAddressLine1")
	public String getPostalAddressLine1() {
		return postalAddressLine1;
	}

	public void setPostalAddressLine1(String postalAddressLine1) {
		this.postalAddressLine1 = postalAddressLine1;
	}

	@Column(name="postalAddressLine2")
	public String getPostalAddressLine2() {
		return postalAddressLine2;
	}

	public void setPostalAddressLine2(String postalAddressLine2) {
		this.postalAddressLine2 = postalAddressLine2;
	}

	@Column(name="postalStateId")
	public Integer getPostalStateId() {
		return postalStateId;
	}

	public void setPostalStateId(Integer postalStateId) {
		this.postalStateId = postalStateId;
	}

	@Column(name="postalCity")
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

	@Column(name="personalMobileNo")
	public String getPersonalMobileNo() {
		return personalMobileNo;
	}

	public void setPersonalMobileNo(String personalMobileNo) {
		this.personalMobileNo = personalMobileNo;
	}

	@Column(name="personalPhoneNo")
	public String getPersonalPhoneNo() {
		return personalPhoneNo;
	}

	public void setPersonalPhoneNo(String personalPhoneNo) {
		this.personalPhoneNo = personalPhoneNo;
	}

	@Column(name="registerType")
	public String getRegisterType() {
		return registerType;
	}

	public void setRegisterType(String registerType) {
		this.registerType = registerType;
	}

	//----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(bidderId);
        sb.append("]:"); 
        sb.append(emailId);
        sb.append("|");
        sb.append(personName);
        sb.append("|");
        sb.append(companyName);
        sb.append("|");
        sb.append(addressline1);
        sb.append("|");
        sb.append(city);
        sb.append("|");
        sb.append(phoneno);
        sb.append("|");
        sb.append(mobileno);
        sb.append("|");
        sb.append(website);
        return sb.toString(); 
    } 

}
