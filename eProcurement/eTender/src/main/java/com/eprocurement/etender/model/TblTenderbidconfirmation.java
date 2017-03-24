/*
 * Created on 24 Nov 2016 ( Time 10:54:39 )
 * Generated by Telosys Tools Generator ( version 2.1.1 )
 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;

import java.util.Date;

import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_tenderbidconfirmation"
 *
 * @author Telosys Tools Generator
 *
 */

@Entity
@Table(name="tbl_tenderbidconfirmation" )
public class TblTenderbidconfirmation implements Serializable
{
    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="bidConfirmationId", nullable=false)
    private Integer    bidconfirmationid ;


    //----------------------------------------------------------------------
    // ENTITY DATA FIELDS 
    //----------------------------------------------------------------------    
    @Column(name="createdBy", nullable=false)
    private Integer    createdby    ;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdOn",nullable=true,updatable=false,insertable=false)
    private Date       createdon    ;

    @Column(name="encodedName")
    private String     encodedname  ;

    @Column(name="ipAddress", nullable=false)
    private String     ipaddress    ;

    @Column(name="bidderid", nullable=false)
    private Integer    bidderid     ;

	// "companyid" (column "companyid") is not defined by itself because used as FK in a link 
	// "tenderid" (column "tenderid") is not defined by itself because used as FK in a link 


    @Column(name="termNcondId", nullable=false)
    private Integer termNcondId;


	public Integer getTermNcondId() {
		return termNcondId;
	}

	public void setTermNcondId(Integer termNcondId) {
		this.termNcondId = termNcondId;
	}


	//----------------------------------------------------------------------
    // ENTITY LINKS ( RELATIONSHIP )
    //----------------------------------------------------------------------
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="companyid", referencedColumnName="companyid")
    private TblCompany tblCompany  ;

    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="tenderid", referencedColumnName="tenderId")
    private TblTender tblTender   ;


    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblTenderbidconfirmation()
    {
		super();
    }
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setBidconfirmationid( Integer bidconfirmationid )
    {
        this.bidconfirmationid = bidconfirmationid ;
    }
    public Integer getBidconfirmationid()
    {
        return this.bidconfirmationid;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : createdBy ( INT ) 
    public void setCreatedby( Integer createdby )
    {
        this.createdby = createdby;
    }
    public Integer getCreatedby()
    {
        return this.createdby;
    }

    //--- DATABASE MAPPING : createdOn ( DATETIME ) 
    public void setCreatedon( Date createdon )
    {
        this.createdon = createdon;
    }
    public Date getCreatedon()
    {
        return this.createdon;
    }

    //--- DATABASE MAPPING : encodedName ( LONGTEXT ) 
    public void setEncodedname( String encodedname )
    {
        this.encodedname = encodedname;
    }
    public String getEncodedname()
    {
        return this.encodedname;
    }

    //--- DATABASE MAPPING : ipAddress ( LONGTEXT ) 
    public void setIpaddress( String ipaddress )
    {
        this.ipaddress = ipaddress;
    }
    public String getIpaddress()
    {
        return this.ipaddress;
    }

    //--- DATABASE MAPPING : bidderid ( INT ) 
    public void setBidderid( Integer bidderid )
    {
        this.bidderid = bidderid;
    }
    public Integer getBidderid()
    {
        return this.bidderid;
    }


    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------
    public void setTblCompany( TblCompany tblCompany )
    {
        this.tblCompany = tblCompany;
    }
    public TblCompany getTblCompany()
    {
        return this.tblCompany;
    }

    public void setTblTender( TblTender tblTender )
    {
        this.tblTender = tblTender;
    }
    public TblTender getTblTender()
    {
        return this.tblTender;
    }


    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(bidconfirmationid);
        sb.append("]:"); 
        sb.append(createdby);
        sb.append("|");
        sb.append(createdon);
        // attribute 'encodedname' not usable (type = String Long Text)
        // attribute 'ipaddress' not usable (type = String Long Text)
        sb.append("|");
        sb.append(bidderid);
        return sb.toString(); 
    } 

}