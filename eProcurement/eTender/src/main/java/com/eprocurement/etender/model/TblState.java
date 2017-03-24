/*
 * Created on 26 Nov 2016 ( Time 05:38:04 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;
//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Persistent class for entity stored in table "tbl_state"
 *
 *
 */

@Entity
@Table(name="tbl_state")
// Define named queries here
public class TblState implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer    stateId      ;
    private String     stateName    ;
    private TblCountry tblCountry  ;

    
    private List<TblBidder> listOfTblBidder;


    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblState() {
		super();
    }
    
    public TblState(int stateId)
    {
    	this.stateId=stateId;
    }
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------
    public void setStateId( Integer stateId ) {
        this.stateId = stateId ;
    }
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="stateId", nullable=false)
    public Integer getStateId() {
        return this.stateId;
    }

    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR FIELDS
    //----------------------------------------------------------------------
    //--- DATABASE MAPPING : stateName ( VARCHAR ) 
    public void setStateName( String stateName ) {
        this.stateName = stateName;
    }
    @Column(name="stateName", nullable=false, length=25)
    public String getStateName() {
        return this.stateName;
    }


    //----------------------------------------------------------------------
    // GETTERS & SETTERS FOR LINKS
    //----------------------------------------------------------------------
    public void setTblCountry( TblCountry tblCountry ) {
        this.tblCountry = tblCountry;
    }
    @ManyToOne
    @JoinColumn(name="countryId", referencedColumnName="countryId")
    public TblCountry getTblCountry() {
        return this.tblCountry;
    }

    public void setListOfTblBidder( List<TblBidder> listOfTblBidder ) {
        this.listOfTblBidder = listOfTblBidder;
    }
    @OneToMany(mappedBy="tblState", targetEntity=TblBidder.class)
    public List<TblBidder> getListOfTblBidder() {
        return this.listOfTblBidder;
    }


    //----------------------------------------------------------------------
    // toString METHOD
    //----------------------------------------------------------------------
    public String toString() { 
        StringBuffer sb = new StringBuffer(); 
        sb.append("["); 
        sb.append(stateId);
        sb.append("]:"); 
        sb.append(stateName);
        return sb.toString(); 
    } 

}
