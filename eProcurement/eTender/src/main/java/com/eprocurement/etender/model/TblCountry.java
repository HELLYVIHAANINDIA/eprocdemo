/*
 * Created on 26 Nov 2016 ( Time 05:36:42 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;

import java.util.List;

import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_country"
 *
 *
 */

@Entity
@Table(name="tbl_country")
// Define named queries here

public class TblCountry implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer    countryId    ;
    private String     countryName  ;
    private String     countryCode  ;
    private List<TblBidder> listOfTblBidder;
    private List<TblState> listOfTblState;
    
    public TblCountry(){
    	super();
    }
    public TblCountry(int countryId) {
		this.countryId=countryId;
    }
    public void setCountryId( Integer countryId ) {
        this.countryId = countryId ;
    }
    
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="countryId", nullable=false)
    public Integer getCountryId() {
        return this.countryId;
    }
    public void setCountryName( String countryName ) {
        this.countryName = countryName;
    }
    @Column(name="countryName", nullable=false, length=25)
    public String getCountryName() {
        return this.countryName;
    }
    public void setCountryCode( String countryCode ) {
        this.countryCode = countryCode;
    }
    @Column(name="countryCode", length=10)
    public String getCountryCode() {
        return this.countryCode;
    }
    public void setListOfTblBidder( List<TblBidder> listOfTblBidder ) {
        this.listOfTblBidder = listOfTblBidder;
    }
    @OneToMany(mappedBy="tblCountry")
    public List<TblBidder> getListOfTblBidder() {
        return this.listOfTblBidder;
    }

    public void setListOfTblState( List<TblState> listOfTblState ) {
        this.listOfTblState = listOfTblState;
    }
    @OneToMany(mappedBy="tblCountry", targetEntity=TblState.class)
    public List<TblState> getListOfTblState() {
        return this.listOfTblState;
    }


    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(countryId);
        sb.append("]:"); 
        sb.append(countryName);
        sb.append("|");
        sb.append(countryCode);
        return sb.toString(); 
    } 

}
