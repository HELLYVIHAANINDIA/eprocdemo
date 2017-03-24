/*
 * Created on 29 Nov 2016 ( Time 11:52:47 )
 * Generated by Telosys Tools Generator ( version 2.1.1 )
 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;

/**
 * Persistent class for entity stored in table "tbl_clientbidterm"
 *
 * @author Telosys Tools Generator
 *
 */

@Entity
@Table(name="tbl_clientbidterm" )
public class TblClientBidTerm implements Serializable
{
    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="clientBidTermId", nullable=false)
    private Integer    clientBidTermId ;


    //----------------------------------------------------------------------
    // ENTITY DATA FIELDS 
    //----------------------------------------------------------------------    
    @Column(name="createdBy", nullable=false)
    private Integer    createdby    ;

    @Column(name="isActive", nullable=false)
    private Integer    isActive   ;

    @Column(name="bidTerm")
    private String     bidTerm      ;

    //----------------------------------------------------------------------
    // CONSTRUCTOR(S)
    //----------------------------------------------------------------------
    public TblClientBidTerm()
    {
		super();
    }
    public TblClientBidTerm(int clientBidTermId){
    	this.clientBidTermId=clientBidTermId;
    }

	@Override
	public String toString() {
		return "TblClientBidTerm [clientBidTermId=" + clientBidTermId
				+ ", createdby=" + createdby + ", isActive=" + isActive
				+ ", bidTerm=" + bidTerm + ", toString()=" + super.toString()
				+ "]";
	}
    
    //----------------------------------------------------------------------
    // GETTER & SETTER FOR THE KEY FIELD
    //----------------------------------------------------------------------

    
}