package com.cahoot.bean;

import java.util.ArrayList;

public class CahootResponse {

	private Boolean Status;

	ArrayList<Country> Country;
	ArrayList<State> State;
	ArrayList<City> City;

	public Boolean getStatus() {
		return Status;
	}

	public void setStatus(Boolean status) {
		Status = status;
	}

	/**
	 * @return the country
	 */
	public ArrayList<Country> getCountry() {
		return Country;
	}

	/**
	 * @param country the country to set
	 */
	public void setCountry(ArrayList<Country> country) {
		Country = country;
	}

	/**
	 * @return the state
	 */
	public ArrayList<State> getState() {
		return State;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(ArrayList<State> state) {
		State = state;
	}

	/**
	 * @return the city
	 */
	public ArrayList<City> getCity() {
		return City;
	}

	/**
	 * @param city the city to set
	 */
	public void setCity(ArrayList<City> city) {
		City = city;
	}
}
