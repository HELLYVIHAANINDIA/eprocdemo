/*
 * Created on 22 Nov 2016 ( Time 07:57:39 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;

import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;




import javax.persistence.*;

/**
 * Persistent class for entity stored in table "tbl_userrolemapping"
 *
 *
 */

@Entity
@Table(name="tbl_biddersectormapping")
// Define named queries here
public class TblBidderSectorMapping implements Serializable {

    private static final long serialVersionUID = 1L;

    //----------------------------------------------------------------------
    // ENTITY PRIMARY KEY ( BASED ON A SINGLE FIELD )
    //----------------------------------------------------------------------
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="bidderSectorMappingId", nullable=false)
    private Integer    bidderSectorMappingId ;
    @Column(name="bidderId", nullable=false)
    private Integer bidderId ;
    @Column(name="sectorId", nullable=false)
    private Integer sectorId;
    
	public Integer getBidderSectorMappingId() {
		return bidderSectorMappingId;
	}
	public void setBidderSectorMappingId(Integer bidderSectorMappingId) {
		this.bidderSectorMappingId = bidderSectorMappingId;
	}
	public Integer getBidderId() {
		return bidderId;
	}
	public void setBidderId(Integer bidderId) {
		this.bidderId = bidderId;
	}
	public Integer getSectorId() {
		return sectorId;
	}
	public void setSectorId(Integer sectorId) {
		this.sectorId = sectorId;
	}


}
