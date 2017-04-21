/*
 * Created on 22 Nov 2016 ( Time 07:57:39 )

 */
// This Bean has a basic Primary Key (not composite) 

package com.eprocurement.etender.model;
import java.io.Serializable;

//import javax.validation.constraints.* ;
//import org.hibernate.validator.constraints.* ;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
    @Column(name="industry")
    private Integer industry;
    @Column(name="activity")
    private Integer activity;
    @Transient
    String industryName;
    @Transient
    String sectorName;
    @Transient
    String activityName;
    
	public Integer getBidderSectorMappingId() {
		return bidderSectorMappingId;
	}
	public String getIndustryName() {
		return industryName;
	}
	public void setIndustryName(String industryName) {
		this.industryName = industryName;
	}
	public String getSectorName() {
		return sectorName;
	}
	public void setSectorName(String sectorName) {
		this.sectorName = sectorName;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
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
	public Integer getIndustry() {
		return industry;
	}
	public void setIndustry(Integer industry) {
		this.industry = industry;
	}
	public Integer getActivity() {
		return activity;
	}
	public void setActivity(Integer activity) {
		this.activity = activity;
	}
}
