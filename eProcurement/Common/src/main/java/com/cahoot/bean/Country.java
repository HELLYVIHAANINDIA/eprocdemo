package com.cahoot.bean;

import java.util.HashMap;
import java.util.Map;

public class Country {
	Long pk;
	String CountryName;
	Map<Long,State> states;

	public Country() {
		super();
		states = new HashMap<Long,State>();
	}

	public Long getPk() {
		return pk;
	}

	public void setPk(Long pk) {
		this.pk = pk;
	}

	public String getCountryName() {
		return CountryName;
	}

	public void setCountryName(String countryName) {
		CountryName = countryName;
	}

	/**
	 * @return the states
	 */
	public Map<Long, State> getStates() {
		return states;
	}

	/**
	 * @param states the states to set
	 */
	public void setStates(Map<Long, State> states) {
		this.states = states;
	}
}
