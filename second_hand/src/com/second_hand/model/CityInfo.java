package com.second_hand.model;

import java.util.List;


public class CityInfo {
	
	private int cityId;                  //城市信息编号
	private String cityName;         //城市名称
	private List<SchoolInfo> schoolInfoList;
	/**
	 * @return the cityId
	 */
	public int getCityId() {
		return cityId;
	}
	/**
	 * @param cityId the cityId to set
	 */
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	/**
	 * @return the cityName
	 */
	public String getCityName() {
		return cityName;
	}
	/**
	 * @param cityName the cityName to set
	 */
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	/**
	 * @return the schoolInfoList
	 */
	public List<SchoolInfo> getSchoolInfoList() {
		return schoolInfoList;
	}
	/**
	 * @param schoolInfoList the schoolInfoList to set
	 */
	public void setSchoolInfoList(List<SchoolInfo> schoolInfoList) {
		this.schoolInfoList = schoolInfoList;
	}
	
	
}
