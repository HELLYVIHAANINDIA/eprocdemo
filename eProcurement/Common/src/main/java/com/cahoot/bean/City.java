package com.cahoot.bean;

public class City {
	Long pk;
	String CityName;
	Long Country_Fk;
	Long State_Fk;

	public Long getPk() {
		return pk;
	}

	public void setPk(Long pk) {
		this.pk = pk;
	}

	public String getCityName() {
		return CityName;
	}

	public void setCityName(String cityName) {
		CityName = cityName;
	}

	public Long getCountry_Fk() {
		return Country_Fk;
	}

	public void setCountry_Fk(Long country_Fk) {
		Country_Fk = country_Fk;
	}

	public Long getState_Fk() {
		return State_Fk;
	}

	public void setState_Fk(Long state_Fk) {
		State_Fk = state_Fk;
	}
}
