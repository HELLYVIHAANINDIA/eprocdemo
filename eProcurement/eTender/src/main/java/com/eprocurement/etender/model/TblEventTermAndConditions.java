/*
 * Created on 8 Nov 2016 ( Time 18:01:15 )
 * Generated by Telosys Tools Generator ( version 2.1.1 )
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
 * Persistent class for entity stored in table "tbl_userlogin"
 *
 *
 */

@Entity
@Table(name="tbl_eventtermandconditions")
// Define named queries here

public class TblEventTermAndConditions implements Serializable {

    private static final long serialVersionUID = 1L;
    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    private int       termNcondId           ;
    private String    termNcondition    ;
    private int       eventType  ;
    private int       eventId ;


    public TblEventTermAndConditions() {
    }
    
    
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="termNcondId", nullable=false)
    public int getTermNcondId() {
		return termNcondId;
	}

	public void setTermNcondId(int termNcondId) {
		this.termNcondId = termNcondId;
	}

	@Column(name="termNcondition", nullable=false, length=2000)
	public String getTermNcondition() {
		return termNcondition;
	}

	public void setTermNcondition(String termNcondition) {
		this.termNcondition = termNcondition;
	}

	@Column(name="eventType",nullable=false)
	public int getEventType() {
		return eventType;
	}

	public void setEventType(int eventType) {
		this.eventType = eventType;
	}
	
	@Column(name="eventId",nullable=false)
	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

}
