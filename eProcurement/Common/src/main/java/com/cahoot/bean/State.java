package com.cahoot.bean;

import java.util.HashMap;
import java.util.Map;

public class State {
	Long pk;
	String StateName;
	Long Country_Fk;
	Map<Long,City> cities;

	public State() {
		super();
		cities = new HashMap<Long,City>();
	}

	public Long getPk() {
		return pk;
	}

	public void setPk(Long pk) {
		this.pk = pk;
	}

	public String getStateName() {
		return StateName;
	}

	public void setStateName(String stateName) {
		StateName = stateName;
	}
	
	

	public Long getCountry_Fk() {
		return Country_Fk;
	}

	public void setCountry_Fk(Long country_Fk) {
		Country_Fk = country_Fk;
	}

	/**
	 * @return the cities
	 */
	public Map<Long, City> getCities() {
		return cities;
	}

	/**
	 * @param cities the cities to set
	 */
	public void setCities(Map<Long, City> cities) {
		this.cities = cities;
	}
}
