package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_eventtype")
public class TblEventType  implements java.io.Serializable {

	  @Id
	  @GeneratedValue(strategy = GenerationType.IDENTITY)
	  @Column(name="eventTypeId",unique=true,nullable=false)
	  private Integer eventTypeId;
	  @Column(name="eventTypeName",nullable=false)
	  private   String eventTypeName;
	  @Column(name="isActive",nullable=false)
	  private   int isActive;
	  
	public TblEventType(){}  
	public TblEventType(Integer eventTypeId, String eventTypeName, int isActive) {
		super();
		this.eventTypeId = eventTypeId;
		this.eventTypeName = eventTypeName;
		this.isActive = isActive;
	}
	public Integer getEventTypeId() {
		return eventTypeId;
	}
	public void setEventTypeId(Integer eventTypeId) {
		this.eventTypeId = eventTypeId;
	}
	public String getEventTypeName() {
		return eventTypeName;
	}
	public void setEventTypeName(String eventTypeName) {
		this.eventTypeName = eventTypeName;
	}
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	  
	  
	  
	  
	  
}
