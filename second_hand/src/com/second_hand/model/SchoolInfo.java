package com.second_hand.model;

import java.util.List;

public class SchoolInfo {

	private int schoolId;                  //学校信息编号
	private String schoolName;       //学校名称
	private CityInfo city;         //城市表记录id
	private List<DepartmentInfo> departInfoList;
	/**
	 * @return the schoolId
	 */
	public int getSchoolId() {
		return schoolId;
	}
	/**
	 * @param schoolId the schoolId to set
	 */
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}
	/**
	 * @return the schoolName
	 */
	public String getSchoolName() {
		return schoolName;
	}
	/**
	 * @param schoolName the schoolName to set
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	/**
	 * @return the city
	 */
	public CityInfo getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(CityInfo city) {
		this.city = city;
	}
	/**
	 * @return the departInfoList
	 */
	public List<DepartmentInfo> getDepartInfoList() {
		return departInfoList;
	}
	/**
	 * @param departInfoList the departInfoList to set
	 */
	public void setDepartInfoList(List<DepartmentInfo> departInfoList) {
		this.departInfoList = departInfoList;
	}


	
	
	
	
}
